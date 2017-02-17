;-------------------------------------
;3(C) 1994 А.А.Иванов (ZX-Ревю N3 1994)
;-------------------------------------
; программа вычисляет адрес экрана по знакоместам
; Вход: DE - позиция в знакоместах
; Выход: DE - экранный адрес
screen_calc_screen_addr_DE:
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
  OR   #40
  LD   D,A
  RET

; перемещаемся на 1 знакоместо ниже
; Вход: HL - экранный адрес
; Выход: HL - экранный адрес

screen_calc_down_DE:
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
  LD D,A
  RET
