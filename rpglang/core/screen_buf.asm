; модуль экранного буфера - копируем туда и обратно
  MODULE ScreenBuf

; копируем 2x2 знакоместа из буфера на экран
; DE - адрес на экране
  MACRO ScreenBuf.buf4_to_scr:
  LD HL, ScreenBuf.cursorBuf
  jp Tiles16.show_tile_on_map
  ENDM

; копируем 2x2 знакоместа в буфер из экрана
; HL - адрес на экране
  MACRO ScreenBuf.scr_to_buf4:
  LD DE, ScreenBuf.cursorBuf
  jp Tiles16.show_tile_on_map
  ENDM

cursorBuf:
  DUP 8*4; буфер под курсором в 4 знакоместа ;)
  defb 00
  EDUP

  ENDMODULE
