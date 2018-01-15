DEVICE zxspectrum128
ORG     #8000

loop_snd_init:
  EI
  LD HL,#0000
  LD B, #ff
loop_snd2:
  LD C,B
  LD B, #ff
loop_snd1:
  LD A, (HL)
  AND A, %00011000;
  INC HL
  OUT (#fe), A
  HALT
  DJNZ loop_snd1
  LD B,C
  DJNZ loop_snd2

  JR loop_snd_init

  DI
  HALT

  LD A,0
  OUT(#FE),A

  LD DE, #4000
  LD HL, TEXT
  LD C, 7
LOOP:
;-----
  LD A,(HL)
  OR A
  JR Z, EXIT
  PUSH HL
  CALL PRINT_68
; ----- CALC_CE ----
  LD A,C
  SUB 6
  JR NC, $+5
  INC E
  AND 7
  LD C,A
;------
  POP HL
  INC HL
  JR LOOP
EXIT:

  DI
  HALT

TEXT:
  db "����� ���� ����������� ��������. "
  db "��� ���� ����� �����. "
  db "����� ���� ����������� ������ �������� ������. "
  db "��������� ���� ���� ��������� ������. "
  db "����� ���� �������� ����� ����������. "
  db "��������� ���� �������� ���� � ��������."
  db "�������� ���� ���� �� �����."
  db "�������� ����� ��� � ������� ���."
 db 0

CALC_CE:
    LD A,C
    SUB 6
    JR NC, $+5
    INC E
    AND 7
    LD C,A
    RET

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

SAVESNA "myzx.sna",loop_snd_init
