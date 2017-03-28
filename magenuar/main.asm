DEVICE zxspectrum128
org #7000;

  include "magenuar/defines.asm"

prg_start:
  call datablock.int_init
  call game.init
  call inventory.show
  ;call game.start
  DI
  HALT
  RET

  include "engine/game.asm"
  include "magenuar/inventory.asm"

  ORG datablock.end_datablock
mage_nuar_spr:
  include "magenuar/mage_nuar.asm"
  DISPLAY "--- datablock2 end: ",$

end_code

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
