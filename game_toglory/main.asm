DEVICE zxspectrum128
org #7000;

  jp prg_start;

  include "engine/defines_engine.asm"
  include "game_toglory/defines.asm"

  include "engine/sys/screen.asm"
  include "engine/sys/input.asm"
  include "engine/sys/shadowscreen.asm"
  include "engine/sys/math.asm"
  include "engine/map.asm"

  include "game_toglory/encounter.asm"
  include "game_toglory/game.asm"

prg_start:
  screen.selectSprSet spriteData  ; init sprites
  map.set mapData                 ; init map data

  call game.init
  call game.start_loop
  RET

mapData:
  include "game_toglory/dummy_map.asm"

spriteData:
  include "game_toglory/rebelstar.asm"

encounterData:
  include "game_toglory/encounter_data.asm"

textData:
    include "game_toglory/lang_ru.asm"

end_code

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
