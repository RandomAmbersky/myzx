; модуль экранного буфера - копируем туда и обратно
  MODULE ScreenBuf

; копируем 2x2 знакоместа из буфера на экран
; DE - адрес на экране
  MACRO ScreenBuf.buf4_to_scr:
  LD HL, ScreenBuf.cursorBuf
  call Tiles16.show_tile_on_map
  ENDM

; копируем 2x2 знакоместа в буфер из экрана
; HL - адрес на экране
scr_to_buf4:
  ;так как адресация экрана не линейная то мы не можем использовать
  ;процедуру печати спрайта как процедуру копирования с экрана :(
  LD DE, ScreenBuf.cursorBuf
  ;копируем 1 тайл с экрана
  ;HL - экранный адрес
  ;DE - указатель на буфер 8x4+4
  PUSH DE
  LD B,8
scr_to_buf4_loop_1:
  ;LDI ; LD (DE),(HL)
  ;LD A,(HL)
  ;LD (DE),A
  ;INC HL
  ;INC DE
  ;LD A,(HL)
  ;LD (DE),A
  ;DEC L
  ;INC H
  ;INC DE
  DJNZ scr_to_buf4_loop_1
  POP DE

  RET

cursorBuf:
  ;DUP 8*4+4; буфер под курсором в 4 знакоместа + 4 атрибута ;)
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0
  ;EDUP

  ENDMODULE
