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

DISPLAY "datablock: ",datablock.datablock_begin,"-",datablock.datablock_end
DISPLAY "shadowscreen: ",datablock.shadowscreen_begin,"-",datablock.shadowscreen_end
DISPLAY "interrupt: ",interrupt.interrupt_begin,"-",interrupt.interrupt_end
DISPLAY "font: ",datablock.font_begin,"-",datablock.font_end

DISPLAY /D, datablock.shadowscreen_begin-datablock.datablock_end, " free0"
DISPLAY /D, interrupt.interrupt_begin-datablock.shadowscreen_end, " free1"
DISPLAY /D, datablock.font_begin-interrupt.interrupt_end, " free2"
DISPLAY /D, 0x10000-datablock.font_end, " free3"

  ;display /D, end_code-prg_start, " size, ", /D, datablock.shadowscreen_begin-end_code, " free"

  SAVESNA "myzx.sna",prg_start
