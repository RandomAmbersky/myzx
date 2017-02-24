  MODULE map

init
  call init_map
  RET

; тестовая функция заполняет спрайтами карту по очереди от 0 до 256 и далее опять 0...
init_map:
  LD HL, mapArray
  LD BC, mapSize * mapSize; ширина x высота
  LD E, #ff
init_map_loop:
  LD (HL),E
  INC HL
  DEC E
  DEC BC
  LD A,B
  OR C
  JR NZ,init_map_loop;
  RET

mapArray DEFS mapSize*mapSize

  ENDMODULE
