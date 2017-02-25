  MODULE gamescreen

include "engine/screen.asm"

mapPos defb 0,0

init:
  initSpriteArray2x2 mapTiles
  LD HL, #0100
  LD (mapPos), HL
  RET

show:
  LD DE, (mapPos)
  call lookAt;
  RET

; показать точку на карте
; в DE - позиция: D-y, E-x
lookAt:
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

scr_up:
  LD A, (mapPos+1)
  DEC A
  RET M
  LD (mapPos+1),A
  RET

scr_down:
  LD A, (mapPos+1)
  INC A
  LD (mapPos+1),A
  RET

scr_left:
  LD A, (mapPos)
  DEC A
  RET M
  LD (mapPos),A
  RET

scr_right:
  LD A, (mapPos)
  INC A
  LD (mapPos),A
  RET


mapTiles include tileFile

  ENDMODULE
