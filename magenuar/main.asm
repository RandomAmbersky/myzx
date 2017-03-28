DEVICE zxspectrum48
org #7000;

prg_start:

  include "magenuar/defines.asm"

  call datablock.int_init
  call game.init
  call inventory.show
  call game.start
  RET

  include "engine/game.asm"
  include "magenuar/inventory.asm"
  ;DISPLAY "--- program end: ",$

  ORG datablock.end_datablock+1
  DISPLAY "--- datablock2 end: ",$

end_code

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
