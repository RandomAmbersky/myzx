
DEVICE zxspectrum48
;org #7000;
;+-------------------------------------------------------------+
;| Ultra-Fast пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ 64 пїЅпїЅпїЅпїЅпїЅпїЅпїЅ: Eraser/Delirium Tremens |
;+-------------------------------------------------------------+
;|пїЅпїЅпїЅпїЅ:  HL    - пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ                        |
;|       DE    - пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅ пїЅпїЅпїЅпїЅпїЅпїЅ (64 byte)|
;|пїЅпїЅпїЅпїЅпїЅ: HL    - пїЅпїЅпїЅпїЅпїЅ пїЅпїЅпїЅпїЅ. пїЅпїЅпїЅпїЅпїЅпїЅпїЅ пїЅ пїЅпїЅпїЅпїЅпїЅпїЅпїЅпїЅ                |
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

  Print64 1, RusNet_HELLO
  Print64 23, RPG_DATA

  DI
  HALT

  RET

PRT_64_POS
  PUSH DE
  CALL screen.calc_str_begin_to_addr
  PUSH DE
  POP HL
  POP DE
  CALL PRT_64
  RET

; функция печати 64 символа в строке
; использует шрифт со сдвоенными буквами в знакоместе
; ( Swap bytes H->L в FONTER2 )

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

PR_64_L LD B,FONT64h
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

PR_64_R LD B,FONT64h
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
  include "lang_ru.asm"

  DISPLAY /D,$-prg_start, " size ", /D, 0x10000-$, " free"
SAVESNA "myzx.sna",prg_start
