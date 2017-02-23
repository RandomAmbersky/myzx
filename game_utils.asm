; рисуем карту
; передвигаем курсор по карте, двигаем окно
; при нажатии 0 - выходим


cursor_select:
;cursor_loop: ; слава капульцевичам!
  LD HL, (WINDOW_POINTER);
  call map_show_map
  LD DE, (CURSOR_POS); E <-- Y, D <-- X
  LD A, (CURSOR_SPRITE)
  call map_show_sprite
WAIT
  call input_sinclair_key;
  CP PRESS_LEFT
  JR Z,LEFT
  CP PRESS_RIGHT
  JR Z,RIGHT
  CP PRESS_DOWN
  JR Z,DOWN
  CP PRESS_UP
  JR Z,UP
  CP PRESS_FIRE
  JR Z,SELECT
  JR cursor_select
RIGHT:
  call map_move_cursor_right
  JR cursor_select
LEFT:
  call map_move_cursor_left
  JR cursor_select
UP:
  call map_move_cursor_up
  JR cursor_select
DOWN:
  call map_move_cursor_down
  ;call map_move_window_down;
  JR cursor_select
SELECT:
  RET
