  MODULE Map

init
  ;call init_map
  RET

; тестовая функция заполняет спрайтами карту по очереди от 0 до 256 и далее опять 0...
init_map:
  LD HL, mapArray
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
  LD DE, mapArray
  ADD HL, DE
  RET

mapArray include mapFile
  ;DEFS mapSize*mapSize

  ENDMODULE
