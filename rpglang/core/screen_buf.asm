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

clean_all_screen:
  LD DE, SCREEN_ADDR
  LD A,24
  CALL clean_rows
  RET

clean_info_screen:
  LD DE, #0*256+22
  CALL math.pos_scr
  PUSH DE;запомнили адрес
  LD A,2
  CALL clean_rows
  POP DE; / адрес
  RET

;в A - ширина окошка
;в DE - адрес первой строки знакоместа
;(!!!) процедура не учитывает переход между третями экрана
clean_rows:
  LD B, A
  PUSH DE
  PUSH BC

show_clean_space_loop_top:
  PUSH BC
  PUSH DE

  LD A, #00
  LD B, 32; экранчик
show_clean_space_loop:
  PUSH DE
  DUP 8
  LD (DE),A
  INC D
  EDUP
  POP DE
  INC DE
  DJNZ show_clean_space_loop

  POP DE
  ;INC E
  LD A, #20
  ADD A,E
  LD E,A
  ;INC D
  POP BC
  DJNZ show_clean_space_loop_top

  POP BC
  POP DE
  CALL math.addr_to_attr

show_clean_space_loop2_lvl2:
  PUSH BC
  LD B, 32; экранчик
  LD A, %00000100
show_clean_space_loop2:
  LD (DE), A
  INC DE
  DJNZ show_clean_space_loop2
  POP BC
  DJNZ show_clean_space_loop2_lvl2
  RET

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
