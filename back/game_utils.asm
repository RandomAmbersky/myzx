; рисуем карту
; передвигаем курсор по карте, двигаем окно
; при нажатии 0 - выходим

game_start:

game_loop:

; draw map
  LD HL, (WINDOW_POINTER)
  call map.show
; draw cursor
  LD DE, (CURSOR_POS); E <-- Y, D <-- X
  LD A, (CURSOR_SPRITE)
  call map.show_sprite

  LD HL, (CURSOR_POS)
  LD (map.MAP_POS), HL
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
  JR game_loop
RIGHT:
  call map.pos_right
  JR POST_PRESS_KEY
LEFT:
  call map.pos_left
  JR POST_PRESS_KEY
UP:
  call map.pos_up
  JR POST_PRESS_KEY
DOWN:
  call map.pos_down
;  JR game_loop
POST_PRESS_KEY:
  LD HL, (map.MAP_POS)
  LD (CURSOR_POS), HL
  call map.pos_to_window_addr
  LD HL, (map.MAP_ADDR)
  LD (WINDOW_POINTER), HL
  JR game_loop
SELECT:
  RET
