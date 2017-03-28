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

; CHARACTERS ZONE
DEFINE persFile "magenuar/character_list.asm"
