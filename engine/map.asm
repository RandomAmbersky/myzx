  MODULE map

; по сути это не совсем map а mapview - так как функций собственно самой карты пока не набралось :)

; это уже подсчеты...
scrWidth equ 32/tileSize ; 32 знакоместа по горизонтали
scrHeight equ 24/tileSize; 24 знакоместа по вертикали

scrWindowMaxX equ mapSize-scrWidth+1  ; максимальная позиция окна отображения карты, иначе выходим за границу
scrWindowMaxY equ mapSize-scrHeight+1 ; максимальная позиция окна отображения карты, иначе выходим за границу

mapPos Point 0,0
curPos Point 0,0
curMode db #09
mapArray dw 00

  MACRO map.set map_p
    LD HL, map_p
    LD (map.mapArray), HL
  ENDM

showCursor:
  LD DE, (curPos)
  LD A, (curMode)
  call show_tile
  RET

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

lookAtPos:
  LD DE, (mapPos)
  ; показать точку на карте
  ; в DE - позиция: D-y, E-x
lookAt:
    call map.pos_to_addr
    call map.showMap
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


; двигаем экран
scr_up:
  LD A, (mapPos.y)
  DEC A
  RET M
  LD (mapPos.y),A
  RET

scr_left:
  LD A, (mapPos.x)
  DEC A
  RET M
  LD (mapPos.x),A
  RET

scr_down:
  LD A, (mapPos.y)
  INC A
  CP scrWindowMaxY
  RET NC
  LD (mapPos.y),A
  RET

scr_right:
  LD A, (mapPos.x)
  INC A
  CP scrWindowMaxX
  RET NC
  LD (mapPos.x),A
  RET

; двигаем курсор
cur_up:
  LD A, (curPos.y)
  DEC A
  JP M, scr_up
  LD (curPos.y),A
  RET

cur_left:
  LD A, (curPos.x)
  DEC A
  JP M, scr_left
  LD (curPos.x),A
  RET

cur_down:
  LD A, (curPos.y)
  INC A
  CP scrHeight
  JP NC, scr_down
  LD (curPos.y),A
  RET

cur_right:
  LD A, (curPos.x)
  INC A
  CP scrWidth
  JP NC, scr_right
  LD (curPos.x),A
  RET

  ENDMODULE
