; модуль вывода тайлов 2x2 знакоместа ( 16 x16 пикселов  )
; для работы надо установить sprArray - указатель на массив тайлов
  MODULE Tiles16

  MACRO Tiles16.setTiles spr_ptr
    LD HL, spr_ptr
    LD (Tiles16.sprArray), HL
  ENDM

  MACRO Tiles16.showTile xy, spr
    LD DE, xy
    LD A, spr
    CALL Tiles16.show_tile
  ENDM

; программа показывает один тайл на экране
; Вход: DE - координаты тайла в позициях тайлов
; A - номер спрайта
show_tile:

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
p_sprArray:
  LD BC, #0000;
  ADD HL, BC
  call math.pos_scr
  PUSH DE
  LD A, #10; number of sprite lines
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL math.down_line; в DE адрес опускаем на линию ниже
  EX AF,AF'
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
  call math.addr_to_attr
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

sprArray EQU p_sprArray+1

  ENDMODULE
