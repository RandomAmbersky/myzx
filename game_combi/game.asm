  MODULE game

init:
  ;call map.init_map
  call heroes.init
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
  ;LD DE, #0000
  ;LD B,0
  ;LD C, encounters.act_stand
  ;call encounters.process_cell_action
  ;call map.showCursor
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
    call map.scr_right
    JR cursor_mode
map_left
    call map.scr_left
    JR cursor_mode
map_up
    call map.scr_up
    JR cursor_mode
map_down
    call map.scr_down
    JR cursor_mode
map_select
    RET

hero_mode:

  RET


  ENDMODULE
