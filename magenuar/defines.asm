; OUR SHADOWSCREEN :)
SCREEN_ADDR_H EQU #C0
SCREEN_ADDR EQU #C000
ATTR_ADDR EQU SCREEN_ADDR+#1800

; MAP ZONE
mapSize=32;100; размер карты; а в RebelStar2 - 50x80
DEFINE mapFile "magenuar/mage_map.asm"

;  TILE ZONE MAGE
DEFINE tileFile "magenuar/mage_sprite.asm"
DEFINE tileSize 4; сколько знакомест в одном спрайте
DEFINE show_tile screen.show_tile_4x4

;GUI SPRITES
DEFINE guiFile "magenuar/mage_nuar.asm"

;FONT SPRITES
DEFINE fontFile "p8_font.bin"
DEFINE FONT_64 #E200
DEFINE FONT_64H #E2

DEFINE langFile "magenuar/lang_ru.asm"

; CHARACTERS ZONE
DEFINE persFile "magenuar/character_list.asm"
