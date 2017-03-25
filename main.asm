
DEVICE zxspectrum48
;org #7000;
;+-------------------------------------------------------------+
;| Ultra-Fast ��������� �� 64 �������: Eraser/Delirium Tremens |
;+-------------------------------------------------------------+
;|����:  HL    - ����� ������ �� ������                        |
;|       DE    - ����� ������������ ������ ��� ������ (64 byte)|
;|�����: HL    - ����� ����. ������� � ��������                |
;+-------------------------------------------------------------+
ORG #8000
prg_start: JP Start

  include "engine/sys/screen.asm"
Start

  MACRO Print64 pos,text
    LD A,pos
    LD DE,text
    CALL PRT_64_POS
  ENDM

  ;Print64 0, RusNet_HELLO
  Print64 23, RPG_DATA

  DI
  HALT

  RET

SPACE
/*
      DEFB 0,1,2,3,4,5,6,7,8,9
      DEFB 10,11,12,13,14,15,16,17,18,19
      DEFB 20,21,22,23,24,25,26,27,28,29
      DEFB 30,31,32,33,34,35,36,37,38,39
      DEFB 40,41,42,43,44,45,46,47,48,49
      DEFB 50,51,52,53,54,55,56,57,58,59
      DEFB 60,61,62,63,64,65,66,67,68,69
      DEFB 70,71,72,73,74,75,76,77,78,79
      DEFB 80,81,82,83,84,85,86,87,88,89
      DEFB 90,91,92,93,94,95,96,97,98,99
      DEFB 100,101,102,103,104,105,106,107,108,109
      DEFB 110,111,112,113,114,115,116,117,118,119
      DEFB 120,121,122,123,124,125,126,127,128,129
      DEFB 130,131,132,133,134,135,136,137,138,139
      DEFB 140,141,142,143,144,145,146,147,148,149
      DEFB 150,151,152,153,154,155,156,157,158,159
      DEFB 160,161,162,163,164,165,166,167,168,169
      DEFB 170,171,172,173,174,175,176,177,178,179
      DEFB 180,181,182,183,184,185,186,187,188,189
      DEFB 190,191,192,193,194,195,196,197,198,199
      DEFB 200,201,202,203,204,205,206,207,208,209
      DEFB 210,211,212,213,214,215,216,217,218,219
      DEFB 220,221,222,223,224,225,226,227,228,229
      DEFB 230,231,232,233,234,235,236,237,238,239
      DEFB 240,241,242,243,244,245,246,247,248,249
      DEFB 250,251,252,253,254,255,0
*/

RusNet_HELLO
  DEFB " ..--=( ~~~~ WELCOME TO RusNet Cyberspace ~~~~ )=--.. ",0
RPG_DATA
  DEFB "��������:20/30 �����:13 �����:10",0

PRT_64_POS
  PUSH DE
  CALL screen.calc_str_begin_to_addr
  PUSH DE
  POP HL
  POP DE
  CALL PRT_64
  RET

PRT_64
        LD A,(DE)
        AND A
        RET Z
        CALL PR_64_L
        INC DE
        LD A,(DE)
        AND A
        RET Z
        CALL PR_64_R
        INC DE
        JR PRT_64

PR_64_L LD B,FONT64h; ������ � ����� ����� ����������
        LD C,A
        DUP 7
        LD A,(BC)
        AND #F0
        LD (HL),A
        INC H
        INC B
        EDUP
        LD A,(BC)
        AND #F0
        LD (HL),A
        LD A,H
        SUB #07
        LD H,A
        RET

PR_64_R LD B,FONT64h; ������ � ������ ����� ����������
        LD C,A
        DUP 7
        LD A,(BC)
        AND #0F
        OR (HL)
        LD (HL),A
        INC H
        INC B
        EDUP
        LD A,(BC)
        AND #0F
        OR (HL)
        LD (HL),A
        LD A,H
        SUB #07
        LD H,A
        INC L
        RET

FONT64 equ #C000
FONT64h equ #C0
ORG FONT64
  incbin "p8_font.bin"

SAVESNA "myzx.sna",prg_start
