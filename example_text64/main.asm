DEVICE zxspectrum48

ORG #8000
prg_start: JP Start

SCREEN_ADDR_H EQU #40
SCREEN_ADDR EQU #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

  include "engine/sys/screen.asm"
  include "engine/sys/text.asm"
  include "example_text64/lang_ru.asm"

Start

  DEFINE FONT_64 #C000
  DEFINE FONT_64H #C0

  LD A, FONT_64H
  CALL Text.setFont64; init font_64
  Text.print64 1, RusNet_HELLO
  Text.print64 23, RPG_DATA

  DI
  HALT

  RET

  ORG FONT_64
  incbin "p8_font.bin"

  DISPLAY /D,$-prg_start, " size ", /D, 0x10000-$, " free"
SAVESNA "myzx.sna",prg_start
