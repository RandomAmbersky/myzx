;UP-SCROLLER
;(C) ZX-MANIACS

;Биты адреса в экранной области имеют следующее значение:
;A15 A14 A13 A12 A11 A10 A9	A8    A7 A6 A5 A4 A3 A2 A1 A0
; 0   1   0   T   T   S	 S	S	    C  C  C  H  H  H  H  H
;010 — адрес #4000, начало экранной области
;TT — номер трети (0..2)
;SSS — номер строки знакоместа
;CCC — номер линии внутри знакоместа

BEGIN_SCREEN_ADDR equ #4000; начало видеопамяти ( #4000 )
;THIRD_PART equ 2; третья часть экрана
;CELL_ROW equ 0; номер строки знакоместа ( 0..7 )
;ROW equ 7; номер строки в трети ( 0...7 )
;COL equ 31; номер столбца ( 0..31 )
;START_SCREEN_HIGH equ THIRD_PART*8+PIX_ROW
;START_SCREEN_LOW equ ROW*32+COL
;SCREEN_POINTER equ BEGIN_SCREEN_ADDR+START_SCREEN_HIGH*256+START_SCREEN_LOW

  MACRO SCREEN _name,_part,_row,_col
_name equ BEGIN_SCREEN_ADDR+(_part*8+0)*256+(_row*32+_col)
  ENDM

  SCREEN _beg, 0, 0, 5
  SCREEN _end, 2, 7, 5

  DEFINE width_cell 22
  DEFINE height_cell 24

  DEFINE left_up_addr _beg
  DEFINE left_down_addr _end+7*256; добавляем номер строки в знакоместе

  ;LD A, 1
  ;OUT (#FE), A

  LD b, #01
  ld hl,0000
rnd_loop:
  PUSH BC
  PUSH HL

  ld de,#4000
  ld bc,6144
  ldir

  POP HL
  POP BC
  INC HL
  DJNZ rnd_loop;

  LD HL, _beg
  LD a, #ff
  LD (HL),A

  LD HL, _end
  LD a, #ff
  LD (HL),A

  ;DI
  ;HALT
  CALL    INIT
  EI
LOOP
  CALL    SCROLL
  DUP 20
  HALT
  EDUP
  JR LOOP
  RET

INIT   LD      HL,TEXT
      LD      (TEXTP),HL
SCROLL LD      HL,(TEXTP)
      XOR     A
      LD      (LINE),A
       LD      A,(HL)
       OR      A
       JR      Z,INIT
       LD      B,8
M1    PUSH    BC
       PUSH    HL
       LD      DE,left_down_addr;22506
       LD      B,width_cell
M2    PUSH    HL
       LD      A,(HL)
       LD      H,0
       LD      L,A
       ADD     HL,HL
       ADD     HL,HL
       ADD     HL,HL
       PUSH    DE
       LD      DE,FONT;(23606)
       ADD     HL,DE
       LD      A,(LINE)
       LD      D,0
       LD      E,A
       ADD     HL,DE
       POP     DE
       LD      A,(HL)
       LD      (DE),A
       INC     DE
       POP     HL
       INC     HL
       DJNZ    M2
       CALL    SRL_UP
       POP     HL
       POP     BC
       LD      A,(LINE)
       INC     A
       LD      (LINE),A
       DJNZ    M1
       LD      HL,(TEXTP)
       LD      DE,width_cell
       ADD     HL,DE
       LD      (TEXTP),HL
       RET
;-------------------------------------
SRL_UP
      LD      DE,left_up_addr
      LD      H,D
      LD      L,E
      INC     H
      ;LD      BC,width_cell*256+height_pix;width_cell*256+height_pix-1
      LD B, width_cell
      LD C, height_cell*8-1
      ;LD BC, #01BF

UPS1  PUSH    BC
      PUSH    HL
UPS2  LD      A,(HL)
      LD      (DE),A
      INC     HL
      INC     DE
      DJNZ    UPS2
      POP     DE
      LD      H,D
      LD      L,E
      INC     H
      LD      A,H
      AND     7
      JR      NZ,NXT_U
      LD      BC,#00E0
      SBC     HL,BC
      LD      A,H
      AND     7
      JR      Z,NXT_U
      LD      B,#07
      LD      C,#00
      SBC     HL,BC
NXT_U POP     BC
      DEC     C
      RET     Z
      JR      UPS1
LINE  DEFB    0
TEXTP DEFW    TEXT

TEXT
  include "dos_fuck.txt"

FONT:
  ;incbin "IBMfont2.bin"
  ;incbin "ST_font.bin"
  ;incbin "f3_font.bin"
  incbin "ober3_font.bin"
