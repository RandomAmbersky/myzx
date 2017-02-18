DEVICE zxspectrum48
org #6000;
prg_start

  call map_show_map;

loop:
  JP loop
  RET

  STRUCT SPRITE

  ENDS

include "ramka.asm"
include "lib/screen_utils.asm"
include "lib/map.asm"

SPR_BEGIN:

  include "test.ASM"
  include "wear_green.ASM"


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
