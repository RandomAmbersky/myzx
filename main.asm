DEVICE zxspectrum48
org #6000;
begin
  LD    A,2
  CALL  5633
  LD    DE,TEXT1    ;печать текста, обозначенного меткой
  LD    BC,TEXT1_end-TEXT1  ; TEXT1, длиной в 16 байт.
  CALL  8252
  CALL  3405        ;восстановление постоянных атрибутов.
  LD    DE,TEXT2    ;печать текста, обозначенного меткой
  LD    BC,TEXT2_end-TEXT2  ; TEXT2, длиной в 11 байт.
  CALL  8252
  di
  halt
  RET
TEXT1  DEFB  22,3,12,16,7,17,2
  DEFM  "TEMPORARY"
TEXT1_end
TEXT2  DEFB  22,5,12
  DEFM  "CONSTANT"
TEXT2_end
end

SAVESNA "myzx.sna",begin
