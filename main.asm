DEVICE zxspectrum48
org #6000;

prg_start:
  call game.init;
  call game.start;
  RET
end_prg

  include "engine/game.asm"

  SAVESNA "myzx.sna",prg_start
