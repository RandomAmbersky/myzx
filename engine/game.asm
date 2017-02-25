  MODULE game

init
  ;call map.init
  call gamescreen.init
  RET

start:
cursor_loop:
  call gamescreen.show
  call input.get_sinclair_key
  CP input.LEFT
  JR Z,LEFT
  CP input.RIGHT
  JR Z,RIGHT
  CP input.DOWN
  JR Z,DOWN
  CP input.UP
  JR Z,UP
  CP input.FIRE
  JR Z,SELECT
  JP cursor_loop
RIGHT
    call gamescreen.scr_right
    JR cursor_loop
LEFT
    call gamescreen.scr_left
    JR cursor_loop
UP
    call gamescreen.scr_up
    JR cursor_loop
DOWN
    call gamescreen.scr_down
    JR cursor_loop
SELECT
    RET

hero_loop:

    RET

  ENDMODULE

  include "engine/defines.asm"
  include "engine/gamescreen.asm"
  include "engine/input.asm"
  include "engine/map.asm"
