; модуль экранного буфера - копируем туда и обратно
  MODULE ScreenBuf

; копируем 2x2 знакоместа из буфера на экран
; DE - адрес на экране
  MACRO ScreenBuf.buf4_to_scr:
  DI
  LD HL, ScreenBuf.cursorBuf
  ;LD HL, GUI_SET+(8*4+4)*2
  call Tiles16.show_tile_on_map
  EI
  ENDM

; копируем 2x2 знакоместа в буфер из экрана
; HL - адрес на экране
;так как адресация экрана не линейная то мы не можем использовать
;процедуру печати спрайта как процедуру копирования с экрана :(
scr_to_buf4:
  DI
  LD DE, ScreenBuf.cursorBuf

  PUSH HL
  LD BC,#0808
scr_to_buf4_loop_1:
  LDI ; LD (DE),(HL)
  LD A,(HL)
  LD (DE),A
  DEC L
  INC H
  INC DE
  DJNZ scr_to_buf4_loop_1
  POP HL

  LD BC, 32
  ADD HL, BC ; HL = HL + 32

  PUSH HL
  LD BC,#0808
scr_to_buf4_loop_2:
  LDI ; LD (DE),(HL)
  LD A,(HL)
  LD (DE),A
  DEC L
  INC H
  INC DE
  DJNZ scr_to_buf4_loop_2
  POP HL

  PUSH DE
  EX DE, HL
  CALL math.addr_to_attr
  EX DE, HL
  POP DE
  LDI // LD (DE),(HL)
  LDI // LD (DE),(HL)
  LD A,L
  ADD A,30
  LD L,A
  LDI
  LDI
  EI
  RET

;cursorBuf equ #5800-32*5

cursorBuf:
  DUP 8*4+4; буфер под курсором в 4 знакоместа + 4 атрибута ;)
  defb #03
  ;defb 0,0,0,0,0,0,0,0
  ;defb 0,0,0,0,0,0,0,0
  ;defb 0,0,0,0,0,0,0,0
  ;defb 0,0,0,0,0,0,0,0,0
  ;defb 255,0,0,0
  EDUP

  ENDMODULE
