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
  LD A, port_keys_6_7_8_9_0
  IN A, (#FE)
  BIT KEY_6_BIT, A
  JR Z,LEFT
  BIT KEY_7_BIT, A
  JR Z,RIGHT
  BIT KEY_8_BIT, A
  JR Z,DOWN
  BIT KEY_9_BIT, A
  JR Z,UP
  BIT KEY_0_BIT, A
  JR Z,SELECT
  JR WAIT
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
