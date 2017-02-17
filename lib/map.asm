; программа показывает один спрайт на карте
; Вход: DE - позиция в координатах карты
; A - номер спрайта
map_call_show_sprite:

  LD HL, DE ; DE x 2 - у нас ширина спрайта =2, то есть позиция 1x1 будет 2x2 в знакоместах
  ADD HL, HL
  LD DE, HL

/*
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
*/
  LD HL, DE
  call screen_calc_scr_addr_HL
  LD DE, HL
  LD HL, test
  LD A, #10
  PUSH DE
spr_loop_1:
  PUSH DE
  LDI ; => LD (DE)(HL); INC DE; INC HL; DEC BC;
  LDI
  POP DE
  EX AF, AF'
  call screen_calc_down_DE
  EX AF, AF'
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
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
