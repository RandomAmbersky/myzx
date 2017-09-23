MODULE map

mapSize_default equ 100

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
  MAP_SHOW_TILE
  /*call Tiles16.show_tile*/
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
  LD A, mapSize_default
  LD C, A
  ADD HL, BC; увеличиваем смещение указателя карты на ее ширину
  POP BC; //origin
  DEC C
  JR NZ, loop2
  RET

mapSize equ add_map_size+1

ENDMODULE
