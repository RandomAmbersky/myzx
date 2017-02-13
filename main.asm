DEVICE zxspectrum48
org #6000;
prg_start

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
