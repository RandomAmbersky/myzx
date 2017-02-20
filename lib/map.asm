STRUCT struct_map_header
width byte 0
height byte 0
ENDS

; функция показа карты
; в HL -  указатель на начало карты
map_show_map:
  LD BC, #100C ; width and height screen - 16 x 12
  LD DE, #0000 ; current pos draw variable
  LD HL, MAP_BEGIN;
map_loop2:
  PUSH BC
  PUSH HL
map_loop:
  PUSH DE
  PUSH BC
  PUSH HL
  LD A,(HL)
  call map_show_sprite
  POP HL
  INC HL
  POP BC
  POP DE
  INC D
  DJNZ map_loop;
  LD D, #00
  INC E
  POP HL; //origin map pointer
  LD B, 0
  LD A, (my_map.width)
  LD C, A
  ;LD C, (my_map.width)
  ;DEC C
  ;LD C, 32
  ADD HL, BC; увеличиваем смещение указателя карты на 32 - ширину экрана
  POP BC; //origin
  DEC C
  JR NZ, map_loop2
  RET

; программа показывает один спрайт на карте
; Вход: DE - позиция в координатах карты
;       A - номер спрайта
map_show_sprite:

  LD HL, DE ; DE x 2 - у нас ширина спрайта =2, то есть позиция 1x1 будет 2x2 в знакоместах
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
  LD A, #10; number of sprite lines
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL screen_calc_down_DE; в DE адрес опускаем на линию ниже
  EX AF,AF'
  ;INC D
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
  call screen_addr_to_attr_DE
  LDI
  LDI
  PUSH HL
  ;LD BC, 30
  ;EX DE, HL
  ;ADD HL, BC
  ;EX DE, HL
  LD a,e
  ADD a,30
  LD e,a
  JR NC, no_down8
  LD a,d
  ADD a,8
  LD d,a
no_down8:
  POP HL
  LDI
  LDI

  RET
