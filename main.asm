DEVICE zxspectrum48
org #6000;
prg_start

  LD DE, #0000
  CALL calc_screen_addr_DE

  ;LD DE, HL
  ;DI
  ;HALT
; в DE - экранный адрес куда нужно выводить спрайт
  LD HL, wear_green
spr_loop_2:
  LD A, #0F
  PUSH DE
spr_loop_1:
  PUSH DE
  LDI ; => LD (DE)(HL); INC DE; INC HL; DEC BC;
  LDI
  POP DE
  EX AF, AF'
  ;call call_down_DE
  INC D
  EX AF, AF'
  DEC A
  JR NZ,spr_loop_1

  ;CALL RAMKA_START

//  LD DE,40
//  LD HL,500
//  CALL 949

  DI
  HALT
  RET
/*
  ld hl,49152
  ld de,16384
  ld bc,6912
  ldir

  LD    A,2
  CALL  5633
  LD    DE,TEXT1    ;печать текста, обозначенного меткой
  LD    BC,TEXT1_end-TEXT1  ; TEXT1, длиной в 16 байт.
  CALL  8252
  CALL  3405        ;восстановление постоянных атрибутов.
  LD    DE,TEXT2    ;печать текста, обозначенного меткой
  LD    BC,TEXT2_end-TEXT2  ; TEXT2, длиной в 11 байт.
  CALL  8252
  di
  halt
  RET

EN_FONT include "fonts/en_font.asm"
*/

  STRUCT SPRITE

  ENDS

include "ramka.asm"
include "lib/screen_utils.asm"
include "wear_green.ASM"
include "test.ASM"

TEXT1  DEFB  22,3,12,16,7,17,2
  DEFM  "TEMPORARY"
TEXT1_end
TEXT2  DEFB  22,5,12
  DEFM  "CONSTANT"
TEXT2_end
end_prg

  SAVESNA "myzx.sna",prg_start
//  DISPLAY /d,end_prg-my_start
//  EMPTYTRD "myzx.trd"
//  SAVETRD "myzx.trd","m.B",16384,EndBasic-Begin
//  SAVETRD "myzx.trd", "m.C", my_start, end_prg-my_start
