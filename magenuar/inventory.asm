  MODULE inventory
show:
  LD DE, #0000
show_inv_map:
  LD A, FONT_64H
  CALL Text.setFont64; init font_64
  ;LD HL, (screen.sprArray)
  ;PUSH HL
  ;LD HL, datablock.guiTiles
  ;LD (screen.sprArray), HL
  ;call show_inv_spr
  Text.print64 1, datablock.tHat
  Text.printNext datablock.tDb

  Text.print64 2, datablock.tMedalion
  Text.printNext datablock.tDb

  Text.print64 3, datablock.tRobe
  Text.printNext datablock.tDb

  Text.print64 4, datablock.tCloak
  Text.printNext datablock.tDb

  Text.print64 5, datablock.tShoes
  Text.printNext datablock.tDb

  Text.print64 6, datablock.tGloves
  Text.printNext datablock.tDb

  Text.print64 7, datablock.tRing
  Text.printNext datablock.tDb

  Text.print64 8, datablock.tWand
  Text.printNext datablock.tDb

  call shadowscreen.show
  call input.get_sinclair_key
  ;POP HL
  ;LD (screen.sprArray), HL
  RET

;RusNet_HELLO
    ;DEFB "          ..--=( ~~~~ MAGE NUAR ~~~~ )=--..          ",0

show_inventory_text:


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

  ENDMODULE
