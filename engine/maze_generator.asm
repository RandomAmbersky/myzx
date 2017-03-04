  MODULE MazeGenerator

init
  call randomize
  call rnd255
  RET
; тестовая функция рисует "решетку на карте"
init_map_grid:
  LD BC, mapSize * mapSize; ширина x высотаs
  RET

ADDR_RND DEFW 0
randomize
  LD HL, (23670)
  LD (ADDR_RND), HL
rnd255
  ;PUSH BC
  ;PUSH DE
  ;PUSH HL
  ; Регистровая пара HL загружается значением из счетчика «случайных» чисел
  ;(это может быть, например, системная переменная 23670/23671,
  ; которая используется Бейсиком для тех же целей)
  LD HL,(ADDR_RND)
  LD DE,7
  ;дальше следует расчет очередного
  ; значения счетчика
  ADD HL,DE
  LD E,L
  LD D,H
  ADD HL,HL
  ADD HL,HL
  LD C,L
  LD B,H
  ADD HL,HL
  ADD HL,BC
  ADD HL,DE
  LD (ADDR_RND),HL
  ;сохранение значения счетчика «случайных»
  ; чисел для последующих расчетов
  LD A,H
  ;регистр A загружается значением
  ; старшего байта счетчика
  ;POP HL
  ;POP DE
  ;POP BC
  RET
; в E - верхняя граница, например от 0 до 50 - надо 51
rnd
  CALL rnd255
  LD L,A
  LD H,0
  LD D,H
  CALL 12457
  LD A,H
  RET

fast_init_maze
  LD HL, map.mapArray
  LD BC, mapSize * mapSize; ширина x высота
  ;LD E, #00
init_fast_map_loop:
  ;PUSH DE
  PUSH BC
  PUSH HL
  call rnd255;
  POP HL
  CP 45
  JR NC, maze_no_life_fast
  LD (HL), 01
maze_no_life_fast:
  POP BC
  ;POP DE
  ;LD (HL),E
  INC HL
  ;INC E
  DEC BC
  LD A,B
  OR C
  JR NZ,init_fast_map_loop;
  RET

; рисуем ЛАБИРИНТ! :)
init_maze
  LD HL, map.mapArray
  LD BC, mapSize*256 + mapSize ;#100C ; width and height screen - 16 x 12
  LD DE, #0000 ; current pos draw variable
maze_loop2:
  PUSH BC
  PUSH HL
maze_loop:
  PUSH DE
  PUSH BC
  PUSH HL
  call rnd
  POP HL
  CP 40
  JR NC, maze_no_life
  LD A, 1
  LD (HL), A
maze_no_life:
  INC HL
  POP BC
  POP DE
  INC D
  DJNZ maze_loop;
  LD D, #00
  INC E
  POP HL; //origin map pointer
  LD B, 0
  LD A, mapSize
  LD C, A
  ADD HL, BC; увеличиваем смещение указателя карты на ее ширину
  POP BC; //origin
  DEC C
  JR NZ, maze_loop2
  RET


ENDMODULE
