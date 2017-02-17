;-------------------------------------
;3(C) 1994 А.А.Иванов (ZX-Ревю N3 1994)
;-------------------------------------
; программа вычисляет адрес экрана по знакоместам
; Вход: DE - позиция в знакоместах
; Выход: DE - экранный адрес

SCREEN_ADDR EQU #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

screen_calc_scr_addr_DE:
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

screen_calc_scr_addr_HL:
  LD A,L
  AND 7
  RRCA
  RRCA
  RRCA
  ADD A,H
  LD H,L
  LD L,A
  LD A,H
  AND #18
  OR #40
  LD H,A
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

; процедура пересчета адреса в экранной области
; в адрес в области атрибутов
; Вход: HL - адрес в экранной области
; Выход: HL - адрес в области атрибутов
screen_addr_to_attr_DE:
  LD A,D
  AND #18
  RRCA
  RRCA
  RRCA
  ADD A,ATTR_ADDR/#100
  LD D,A
  RET
