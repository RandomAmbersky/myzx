  MODULE game

init
  ;call Sound.rnd
  call Map.init
  call MazeGenerator.init
  call MazeGenerator.fast_init_maze
  call Personages.init
  call Gamescreen.init
  RET

start:
  ;call Sound.skrebok
  ;ret

cursor_loop:
  ;call Sound.rnd
  ;call Gamescreen.getCursorCell; в Gamescreen.mapCurPos координаты ячейки карты на которую показывает курсор
  ;LD DE, ( Gamescreen.mapCurPos ); проверяем показывает ли персонаж на курсор
;display /H, $
  ;screen.PRINT_AT_FF 1, 1, 10
  ;LD DE, ( Gamescreen.mapCurPos ); проверяем показывает ли персонаж на курсор
  ;call Personages.find_at
  ;CP 1
  ;RET Z;
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
    LD A,1
    call Gamescreen.lookAtHero
    ;call Sound.hiss
    JR cursor_loop
    ;RET

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
  include "engine/sound.asm"
  include "engine/input.asm"
  include "engine/map.asm"
  include "engine/maze_generator.asm"
