DEVICE zxspectrum128
org #7000;

  jp prg_start;

  include "engine/defines_engine.asm"
  include "game_combi/defines.asm"

  include "engine/sys/screen.asm"
  include "engine/sys/input.asm"
  include "engine/sys/text.asm"
  include "engine/sys/shadowscreen.asm"
  include "engine/map.asm"

  include "game_combi/game.asm"
  include "game_combi/encounters.asm"

prg_start:
  screen.selectSpriteSet spriteData  ; init sprites
  map.set mapData                 ; init map data

  call game.init
  call game.start_loop
  RET

mapData:
  include "game_combi/dummy_map.asm"

spriteData:
  include "game_combi/rebelstar.asm"

;encounterData:
  ;include "game_toglory/encounter_data.asm"

textData:
    include "game_combi/lang_ru.asm"

end_code

  display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

  SAVESNA "myzx.sna",prg_start
