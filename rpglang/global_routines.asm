MODULE routines

/*
; а надо ли это сделать? ;)
; пока недоделано формирование таблицы
fill_scr_table:

  LD DE, SCREEN_ADDR
  LD HL, globaldata.SCREEN_ADDR_TABLE

  LD B, scrHeight
loop_line:
  PUSH BC

  LD B, scrWidth
loop_col:
  LD (HL), DE
  INC HL
  INC HL
  DJNZ loop_col

  POP BC
  DJNZ loop_line

  RET
*/
ENDMODULE
