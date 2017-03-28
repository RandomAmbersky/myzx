  MODULE game

init:
  LD HL, #0000
  LD (map.mapPos), HL
  LD HL, #0303
  LD (map.curPos), HL
  RET

start_loop:
  call cursor_mode
  jp start_loop
  RET


cursor_mode: ;обозреваем карту
  call map.lookAtPos
  call map.showCursor
  call shadowscreen.show
  call input.get_sinclair_key
  CP input.LEFT
  JR Z,map_left
  CP input.RIGHT
  JR Z,map_right
  CP input.DOWN
  JR Z,map_down
  CP input.UP
  JR Z,map_up
  CP input.FIRE
  JR Z,map_select
  JP cursor_mode
  RET

map_right
    call map.cur_right
    JR cursor_mode
map_left
    call map.cur_left
    JR cursor_mode
map_up
    call map.cur_up
    JR cursor_mode
map_down
    call map.cur_down
    JR cursor_mode
map_select
    RET

hero_mode:

  RET


  ENDMODULE