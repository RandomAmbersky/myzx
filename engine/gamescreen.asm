  MODULE gamescreen

include "engine/screen.asm"

init:
  initSpriteArray2x2 mapTiles
  RET

; функция показа карты
show:
  call showMap
  RET

showMap:
  LD HL, map.mapArray
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

mapTiles include tileFile

  ENDMODULE
