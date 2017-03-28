DEVICE zxspectrum48
org #7000;

prg_start:

  include "magenuar/defines.asm"

  call interrupt.int_init
  call game.init
  call inventory.show
  call game.start
  RET

  include "magenuar/inventory.asm"
  include "engine/game.asm"
ORG datablock.end_datablock
DISPLAY "--- datablock2 begin: ",$
mage_nuar_spr:
      include "magenuar/mage_nuar.asm"
  DISPLAY "--- datablock2 end: ",$

end_code

include "engine/interrupt.asm"

DISPLAY "shadowscreen begin: ",datablock.shadowscreen_begin
DISPLAY "shadowscreen end: ",datablock.shadowscreen_end

DISPLAY "interrupt begin: ",interrupt.interrupt_begin
DISPLAY "interrupt end: ",interrupt.interrupt_end

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
