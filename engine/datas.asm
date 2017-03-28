  MODULE datablock

datablock_begin:
mapTiles include tileFile
mapArray include mapFile
;guiTiles include guiFile
textData include langFile
datablock_end:

ORG #C000
shadowscreen_begin:
SHADOW_SCREEN_ADDR:
 DS SCREEN_TOTAL_SIZE-SCREEN_ATTRIBUTES_SIZE
SHADOW_ATTR_ADDR:
 DS SCREEN_ATTRIBUTES_SIZE, %00111000
shadowscreen_end:

ORG FONT_64
font_begin:
incbin "p8_font.bin"
font_end:

  ENDMODULE
