  MODULE game

init
  call Map.init
  call MazeGenerator.init
  call MazeGenerator.fast_init_maze
  call Personages.init
  call Gamescreen.init
  RET

start:

cursor_loop:
  call Gamescreen.show
  call input.get_sinclair_key
  ;JP move_map;
  JP move_cursor;

move_map:
  CP input.LEFT
  JR Z,MAP_LEFT
  CP input.RIGHT
  JR Z,MAP_RIGHT
  CP input.DOWN
  JR Z,MAP_DOWN
  CP input.UP
  JR Z,MAP_UP
  CP input.FIRE
  JR Z,MAP_SELECT
  JP cursor_loop

move_cursor:
  CP input.LEFT
  JR Z,CUR_LEFT
  CP input.RIGHT
  JR Z,CUR_RIGHT
  CP input.DOWN
  JR Z,CUR_DOWN
  CP input.UP
  JR Z,CUR_UP
  CP input.FIRE
  JR Z,CUR_SELECT
  JP cursor_loop

CUR_RIGHT
    call Gamescreen.cur_right
    JR cursor_loop
CUR_LEFT
    call Gamescreen.cur_left
    JR cursor_loop
CUR_UP
    call Gamescreen.cur_up
    JR cursor_loop
CUR_DOWN
    call Gamescreen.cur_down
    JR cursor_loop
CUR_SELECT
    RET

MAP_RIGHT
    call Gamescreen.scr_right
    JR cursor_loop
MAP_LEFT
    call Gamescreen.scr_left
    JR cursor_loop
MAP_UP
    call Gamescreen.scr_up
    JR cursor_loop
MAP_DOWN
    call Gamescreen.scr_down
    JR cursor_loop
MAP_SELECT
    RET


hero_loop:

    RET

  ENDMODULE

  include "engine/defines.asm"
  include "engine/gamescreen.asm"
  include "engine/personages.asm"
  include "engine/input.asm"
  include "engine/map.asm"
  include "engine/maze_generator.asm"
