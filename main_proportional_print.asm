
  LD A,1
  OUT(#FE),A

  LD DE, #4000
  LD A, 'Х'
  LD C, 7
  CALL PRINT_68

  LD DE, #400A
  LD A, 'х'
  LD C, 7
  CALL PRINT_68

  DI
  HALT

; (c) Alone Coder
;   Быстрая печать буквы 6x8 (экран в DE):

; Регистр C должен содержать 7,5,3 или 1,
; причем  7 соответствует нулевой координате
; буквы внутри знакоместа(x mod 8=0).

PRINT_68:
  PUSH DE
  LD L,A
  LD B,C
  LD A,#80 ; ( 10000000 )
  RRCA
  DJNZ $-1
  LD (PRN+1),A
  LD H, HIGH FONT
  LD B,8
PRGO:
  PUSH HL
  LD L,(HL)
PRN:
  LD H,1
PR1:
  ADD HL,HL
  ADD HL,HL
  JR NC,PR1
  LD A,(DE)
  OR H
  LD (DE),A
  INC E
  LD A,L
  LD (DE),A
  DEC E
  INC D
  POP HL
  INC H
  DJNZ PRGO
  POP DE
  RET

  ORG (HIGH $+1)*256
FONT:
  /*defb %11111100
  defb %10000100
  defb %10000100
  defb %10000100
  defb %10000100
  defb %10000100
  defb %10000100
  defb %10101000

  defb %01111100
  defb %00000100
  defb %00000100
  defb %00000100
  defb %00000100
  defb %00000100
  defb %00000100
  defb %11111100*/
  incbin "AONfont_revert.fnt"
  ;incbin "f3_font.bin"


DISPLAY FONT, ' font'
DISPLAY HIGH FONT, ' high font'
