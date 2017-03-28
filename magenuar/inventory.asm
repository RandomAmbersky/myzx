  MODULE inventory
show:
  LD DE, #0000
show_inv_map:
  LD HL, (screen.sprArray)
  PUSH HL
  LD HL, mage_nuar_spr
  LD (screen.sprArray), HL
  call show_inv_spr
  call shadowscreen.show
  call input.get_sinclair_key
  POP HL
  LD (screen.sprArray), HL
  RET

show_inv_spr:
  LD A, 8
  LD ( Gamescreen.add_map_size + 1 ), A
  LD HL,inv_map
  LD BC, 8*256+6;scrWidth*256 + scrHeight ;
  LD DE, #0000 ; current pos draw variable
  call Gamescreen.loop2
  RET

inv_map:
  defb 00,01,02,03,04,05,01,01;
  defb 08,01,10,11,12,13,01,01;
  defb 16,01,18,19,20,21,01,01;
  defb 24,01,26,27,28,29,01,01;
  defb 32,01,34,35,36,37,01,01;
  defb 40,01,42,43,44,45,01,01;
  defb 48,01,50,51,52,53,01,01;

mage_nuar_spr:
    include "magenuar/mage_nuar.asm"

  ENDMODULE
