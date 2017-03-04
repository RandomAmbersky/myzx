  MODULE Gamescreen

include "engine/screen.asm"

; это уже подсчеты...
scrWidth equ 32/tileSize ; 32 знакоместа по горизонтали
scrHeight equ 24/tileSize; 24 знакоместа по вертикали

scrWindowMaxX equ mapSize-scrWidth+1  ; максимальная позиция окна отображения карты, иначе выходим за границу
scrWindowMaxY equ mapSize-scrHeight+1 ; максимальная позиция окна отображения карты, иначе выходим за границу

mapPos Point 0,0
curPos Point 0,0

init:
  initSpriteArray mapTiles
  LD HL, #0000
  LD (mapPos), HL
  LD HL, #0000
  LD (curPos), HL
  RET

show:
  call lookAtMap_def;
  LD DE, (curPos)
  LD A, #09
  call show_tile

  call getCursorCell

  LD C, A
  LD B, 0
  LD DE, #0101
  call screen.print_at_ff

  RET

; получить код ячейки под курсором
; Вход - нет, все берется из mapPos и curPos
; Выход:
;   A - код в ячейке карты под курсором
getCursorCell:
  LD DE, (mapPos)
  LD HL, (curPos)
  ADD HL, DE
  PUSH HL
  POP DE
  call Map.pos_to_addr
  LD A, (HL)
  RET

; показать точку на карте
; в DE - позиция: D-y, E-x
lookAtMap_def:
  LD DE, (mapPos)
lookAtMap:
  call Map.pos_to_addr
  call showMap
  RET

; функция показа карты
; в HL - указатель на позицию в mapArray
showMap:
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
  LD A, mapSize
  LD C, A
  ADD HL, BC; увеличиваем смещение указателя карты на ее ширину
  POP BC; //origin
  DEC C
  JR NZ, loop2
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

mapTiles include tileFile

  ENDMODULE
