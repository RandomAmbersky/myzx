DEVICE zxspectrum48
org #7000;

prg_start:
  call game.init
  call game.start
  RET

  include "engine/game.asm"

end_code

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
