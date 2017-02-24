  MODULE game

init
  call map.init
  RET

start
  call gamescreen.show
  call input.get_sinclair_key
  RET

  ENDMODULE

  include "engine/defines.asm"
  include "engine/gamescreen.asm"
  include "engine/input.asm"
  include "engine/map.asm"
