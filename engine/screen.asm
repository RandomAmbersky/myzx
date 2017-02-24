  MODULE screen

  ;-------------------------------------
  ;3(C) 1994 А.А.Иванов (ZX-Ревю N3 1994)
  ;-------------------------------------
  ; программа вычисляет адрес экрана по знакоместам
  ; Вход: DE - позиция в знакоместах
  ; Выход: DE - экранный адрес

SCREEN_ADDR EQU #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

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
    OR   #40
    LD   D,A
    RET

; процедура пересчета адреса в экранной области
; в адрес в области атрибутов
; Вход: HL - адрес в экранной области
; Выход: HL - адрес в области атрибутов
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
  ; Вход: HL - экранный адрес
  ; Выход: HL - экранный адрес

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
    LD D,A
    RET

  ENDMODULE
