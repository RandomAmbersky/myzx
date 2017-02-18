DEVICE zxspectrum48
org #6000;
prg_start

  call map_show_map;

  LD HL, #0F0B
  LD A, #01
  call map_show_sprite

loop:
  JP loop
  RET

  STRUCT SPRITE

  ENDS

include "lib/screen_utils.asm"
include "lib/map.asm"

SPR_BEGIN:

  include "test.ASM"
end_prg

  SAVESNA "myzx.sna",prg_start
//  DISPLAY /d,end_prg-my_start
//  EMPTYTRD "myzx.trd"
//  SAVETRD "myzx.trd","m.B",16384,EndBasic-Begin
//  SAVETRD "myzx.trd", "m.C", my_start, end_prg-my_start
