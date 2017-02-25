  MODULE gamescreen

include "engine/screen.asm"

scrWidth equ #10
scrHeight equ #0C

scrWindowMaxX equ mapSize-scrWidth+1  ; максимальная позиция окна отображения карты, иначе выходим за границу
scrWindowMaxY equ mapSize-scrHeight+1 ; максимальная позиция окна отображения карты, иначе выходим за границу

mapPos defb 0,0
curPos defb 0,0

init:
  initSpriteArray2x2 mapTiles
  LD HL, #0000
  LD (mapPos), HL
  LD (curPos), HL
  RET

show:
  LD DE, (mapPos)
  call lookAtMap;
  LD DE, (curPos)
  LD A, E
  LD E, D
  LD D, A
  LD A, #ff
  call screen.show_sprite_2x2
  RET

;show_cursor:
  ;LD DE, (curPos)
  ;LD A, #FF


; показать точку на карте
; в DE - позиция: D-y, E-x
lookAtMap:
  call map.pos_to_addr
  call showMap
  RET

; функция показа карты
; в HL - указатель на позицию в mapArray
showMap:
  LD BC, #100C ; width and height screen - 16 x 12
  LD DE, #0000 ; current pos draw variable
loop2:
  PUSH BC
  PUSH HL
loop:
  PUSH DE
  PUSH BC
  PUSH HL
  LD A,(HL)
  call screen.show_sprite_2x2
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
  LD A, (mapPos+1)
  DEC A
  RET M
  LD (mapPos+1),A
  RET

scr_left:
  LD A, (mapPos)
  DEC A
  RET M
  LD (mapPos),A
  RET

scr_down:
  LD A, (mapPos+1)
  INC A
  CP scrWindowMaxY
  RET NC
  LD (mapPos+1),A
  RET

scr_right:
  LD A, (mapPos)
  INC A
  CP scrWindowMaxX
  RET NC
  LD (mapPos),A
  RET

; двигаем курсор
cur_up:
  LD A, (curPos+1)
  DEC A
  JP M, scr_up
  LD (curPos+1),A
  RET

cur_left:
  LD A, (curPos)
  DEC A
  JP M, scr_left
  LD (curPos),A
  RET

cur_down:
  LD A, (curPos+1)
  INC A
  CP scrHeight
  JP NC, scr_down
  LD (curPos+1),A
  RET

cur_right:
  LD A, (curPos)
  INC A
  CP scrWidth
  JP NC, scr_right
  LD (curPos),A
  RET

mapTiles include tileFile

  ENDMODULE
