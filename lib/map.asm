; программа показывает один спрайт на карте
; Вход: DE - позиция в координатах карты
; A - номер спрайта
map_call_show_sprite:
  ADD D,D
  ADD E,E
  call screen_calc_screen_addr_DE
  LD HL, test
spr_loop_2:
  LD A, #0F
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
  RET
