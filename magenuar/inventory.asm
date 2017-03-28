  MODULE inventory
show:
  ;LD HL, mage_nuar_spr
  ;LD (screen.sprArray), HL
show_inv_map:
  LD HL, mage_nuar_spr
  LD DE, datablock.SHADOW_SCREEN_ADDR
  LD A, 32
  call screen.spr_loop_4x4
  call shadowscreen.show
  RET

inv_map:
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  defb 0,0,0,0,0,0,0,0
  ENDMODULE
