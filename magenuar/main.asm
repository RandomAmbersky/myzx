DEVICE zxspectrum48
org #7000;

prg_start:

  include "magenuar/defines.asm"

  call interrupt.int_init
  call game.init
  call inventory.show
  call game.start
  RET

  include "engine/game.asm"
end_code

  include "engine/interrupt.asm"

DISPLAY "datablock begin: ",datablock.datablock_begin
DISPLAY "datablock end: ",datablock.datablock_end

DISPLAY "shadowscreen begin: ",datablock.shadowscreen_begin
DISPLAY "shadowscreen end: ",datablock.shadowscreen_end

DISPLAY "interrupt begin: ",interrupt.interrupt_begin
DISPLAY "interrupt end: ",interrupt.interrupt_end

DISPLAY /D, datablock.shadowscreen_begin-datablock.datablock_end, " free1"
DISPLAY /D, interrupt.interrupt_begin-datablock.shadowscreen_end, " free2"

  ;display /D, end_code-prg_start, " size, ", /D, datablock.shadowscreen_begin-end_code, " free"

  SAVESNA "myzx.sna",prg_start
