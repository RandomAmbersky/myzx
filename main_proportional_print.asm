
  LD A,1
  OUT(#FE),A

  LD DE, #4000
  LD A, '�'
  LD C, 7
  CALL PRINT_68

  LD DE, #400A
  LD A, '�'
  LD C, 7
  CALL PRINT_68

  DI
  HALT

; (c) Alone Coder
;   ������� ������ ����� 6x8 (����� � DE):

; ������� C ������ ��������� 7,5,3 ��� 1,
; ������  7 ������������� ������� ����������
; ����� ������ ����������(x mod 8=0).

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
