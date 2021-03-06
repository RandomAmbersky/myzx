  MODULE map

; это уже подсчеты...
scrWidth equ 32/tileSize ; 32 знакоместа по горизонтали
scrHeight equ 24/tileSize; 24 знакоместа по вертикали

mapArray dw 00

  MACRO map.set map_p
    LD HL, map_p
    LD (map.mapArray), HL
  ENDM

; тестовая функция заполняет спрайтами карту по очереди от 0 до 256 и далее опять 0...
init_map:
  LD HL, (map.mapArray)
  LD BC, mapSize * mapSize; ширина x высота
  LD E, #00
init_map_loop:
  LD (HL),E
  INC HL
  INC E
  DEC BC
  LD A,B
  OR C
  JR NZ,init_map_loop;
  RET

  ; функция показа карты
  ; в HL - указатель на позицию в mapArray
showMap:
    LD A, mapSize
    LD (add_map_size+1), A
    LD BC, scrWidth*256 + scrHeight ;#100C ; width and height screen - 16 x 12
    LD DE, #0000 ; current pos draw variable
loop2:
    PUSH BC
    PUSH HL
loop:
    PUSH DE
    PUSH BC
    PUSH HL
    LD A,(HL)
    call show_tile
    POP HL
    INC HL
    POP BC
    POP DE
    INC D
    DJNZ loop;
    LD D, #00
    INC E
    POP HL; //origin map pointer
    LD B, 0
add_map_size:
    LD A, mapSize
    LD C, A
    ADD HL, BC; увеличиваем смещение указателя карты на ее ширину
    POP BC; //origin
    DEC C
    JR NZ, loop2
    RET

; переводим pos в указатель на ячейку в массиве карты
; Вход: DE - pos,  D - x, E - y
; Выход: HL - указатель
pos_to_addr
  LD HL, #0000
  LD C,D; запоминаем posX в C
  LD A,E
  CP 00
  JR Z, no_mul; если ноль по Y то не будем прибавлять ничего
  LD B,E; кидаем posY в B - по B будет автодекрементный цикл
  LD DE, mapSize;
mul_loop
  ADD HL,DE
  DJNZ mul_loop
no_mul
  LD D,0
  LD E,C
  ADD HL,DE; в HL у нас
  LD DE, (map.mapArray)
  ADD HL, DE
  RET

  ENDMODULE
