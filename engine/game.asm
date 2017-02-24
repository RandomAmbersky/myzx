  MODULE game

init
  call map.init
  call gamescreen.init
  RET

start:
cursor_mode_loop:
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
  JP cursor_mode_loop
RIGHT
    RET
    ;call map.pos_right
    JR cursor_mode_loop
LEFT
    ;call map.pos_left
    JR cursor_mode_loop
UP
    ;call map.pos_up
    JR cursor_mode_loop
DOWN
    ;call map.pos_down
    JR cursor_mode_loop
SELECT
    RET

hero_mode_loop:

    RET

  ENDMODULE

  include "engine/defines.asm"
  include "engine/gamescreen.asm"
  include "engine/input.asm"
  include "engine/map.asm"
