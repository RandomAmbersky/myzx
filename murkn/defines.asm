; OUR SHADOWSCREEN :)
SCREEN_ADDR_H EQU #C0
SCREEN_ADDR EQU #C000
ATTR_ADDR EQU SCREEN_ADDR+#1800

; MAP ZONE
mapSize=32;100; размер карты; а в RebelStar2 - 50x80
DEFINE mapFile "murkn/dummy_map.asm"

;  TILE ZONE REBELSTAR
DEFINE tileFile "murkn/rebelstar.asm"
DEFINE tileSize 2; сколько знакомест в одном спрайте
DEFINE show_tile screen.show_tile_2x2

; CHARACTERS ZONE
DEFINE persFile "murkn/character_list.asm"
