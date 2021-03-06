  MODULE screen

  ;-------------------------------------
  ;(C) 1994 А.А.Иванов (ZX-Ревю N3 1994)
  ;-------------------------------------
  ; программа вычисляет адрес экрана по знакоместам
  ; Вход: DE - позиция в знакоместах
  ; Выход: DE - экранный адрес

sprArray defw 0; указатель на массив спрайтов

  MACRO screen.selectSprSet spr
      LD HL, spr
      LD (screen.sprArray), HL
    ENDM

; вычисляем позицию адрес по позиции знакоместа
; DE - D-x, E-y
calc_pos_to_addr_DE:
    LD A,E
    AND  7
    RRCA
    RRCA
    RRCA
    ADD  A,D
    LD   D,E
    LD   E,A
    LD   A,D
    AND  #18
    OR   SCREEN_ADDR_H
    LD   D,A
    RET

; вычисляем адресацию экрана по номеру строчки
; Вход: A - номер строчки
; Выход - DE - адрес экрана
calc_str_begin_to_addr: //E-y
    PUSH AF
    AND #18
    OR SCREEN_ADDR_H
    LD D,A
    POP AF
    AND 7
    RRCA
    RRCA
    RRCA
    LD E,A
    RET

; процедура пересчета адреса в экранной области
; в адрес в области атрибутов
; Вход: DE - адрес в экранной области
; Выход: DE - адрес в области атрибутов
addr_to_attr_DE:
  LD A,D
  AND #18
  RRCA
  RRCA
  RRCA
  ADD A,ATTR_ADDR/#100
  LD D,A
  RET

; перемещаемся на 1 линию в знакоместе ниже
; Вход: DE- экранный адрес
; Выход: DE - экранный адрес
calc_down_line_DE:
    INC D
    LD A,D
    AND 7
    RET NZ
    LD A,E
    ADD A,#20
    LD E,A
    RET C
    LD A,D
    SUB 8
    ;ADD A,-8
    LD D,A
    RET

; программа показывает один спрайт на карте
; Вход: DE - координаты знакоместа в координатах экрана
;       A - номер спрайта
show_tile_4x4:
  LD HL, DE ; DE x 4 - у нас ширина спрайта =2, то есть позиция 1x1 будет 4x4 в знакоместах
  ADD HL, HL
  ADD HL, HL
  LD DE, HL

  LD L, A
  LD H, 0; загружаем номер спрайта в HL
  ADD HL,HL; x2
  ADD HL,HL; x4
  ADD HL,HL; x8
  ADD HL,HL; x16
  PUSH HL
  ADD HL,HL; x32
  ADD HL,HL; x64
  ADD HL,HL; x128
  POP BC
  ADD HL,BC
  LD BC, (sprArray);
  ADD HL, BC;
  call calc_pos_to_addr_DE
  LD A, 32
spr_loop_4x4
    PUSH DE
    LDI
    LDI
    LDI
    LDI
    POP DE
    EX AF,AF'
    CALL calc_down_line_DE; в DE адрес опускаем на линию ниже
    EX AF,AF'
    DEC A
    JR NZ,spr_loop_4x4

  RET

; программа показывает один спрайт на карте
; Вход: DE - координаты знакоместа в координатах экрана
;       A - номер спрайта
show_tile_2x2:

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
  LD BC, (sprArray);
  ADD HL, BC;

  call calc_pos_to_addr_DE
  PUSH DE
  LD A, #10; number of sprite lines
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL calc_down_line_DE; в DE адрес опускаем на линию ниже
  EX AF,AF'
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
  call addr_to_attr_DE
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

; DE - D - y, E - x
; BC - число
;MACRO PRINT_AT_FF x,y,f
  ;LD B, 0
  ;LD C, f
  ;LD D, x
  ;LD E, y
  ;call print_at_ff
;ENDM

; DE - D - y, E - x
; BC - число
print_at_ff
  PUSH BC

  LD A, D
  LD ( DATA1+1), A
  LD A, E
  LD ( DATA1+2), A

  LD A,2
  CALL 5633

  LD DE,DATA1
  LD BC,5
  CALL 8252

  POP BC
  CALL 6683

  RET
DATA1 DEFB 22,5,14     ;управляющие коды для AT 5,14
      DEFB  20,1        ;управляющие коды для INVERSE 1
;  SETSCR .........

  ENDMODULE
