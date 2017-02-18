; функция показа карты
map_show_map:
  ;LD BC, #100C ; width and height  - 16 x 12
  LD BC, #100C
  LD HL, #0000 ; current pos variable
map_loop2:
  PUSH BC
map_loop:
  PUSH BC
  PUSH HL
  LD A, #0
  call map_show_sprite
  POP HL
  POP BC
  INC H
  DJNZ map_loop;
  LD H, #00
  INC L
  POP BC; //origin
  DEC C
  JR NZ, map_loop2
  RET

; программа показывает один спрайт на карте
; Вход: HL - позиция в координатах карты
;       A - номер спрайта
map_show_sprite:

  ;LD HL, DE ; DE x 2 - у нас ширина спрайта =2, то есть позиция 1x1 будет 2x2 в знакоместах
  ADD HL, HL
  LD DE, HL

  LD L, A
  LD H, 0; загружаем номер спрайта в HL
  ADD HL,HL; x2
  ADD HL,HL; x4
  PUSH HL; // запоминаем x4
  ADD HL,HL; x8
  ADD HL,HL; x16
  ADD HL,HL; x32
  POP BC; // снимаем со стека x4 - еще 4 байта цветности
  ADD HL, BC
  LD BC, SPR_BEGIN;
  ADD HL, BC;

  call screen_calc_scr_addr_DE
  PUSH DE
  LD A, #10
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL screen_calc_down_DE; в DE адрес опускаем на линию ниже
  EX AF,AF'
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
  RET
  call screen_addr_to_attr_DE
  LDI
  LDI
  PUSH HL
  LD BC, 30
  LD HL, DE
  ADD HL, BC
  LD DE, HL
  POP HL
  LDI
  LDI

  RET
