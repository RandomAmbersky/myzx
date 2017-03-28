  MODULE encounter

  DEFINE bit_not_moved %00000001; непроходимо
  DEFINE bit_opened    %00000010
  DEFINE bit_character %00000100; это персонаж (?) мы вроде и так сначала проверяем на "персонажесть

STRUCT encounter_str
bitset1 db 00; // type
name dw 00; pointer to name
ENDS


  ENDMODULE
