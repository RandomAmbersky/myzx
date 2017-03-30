; OUR SHADOWSCREEN :)
SCREEN_ADDR_H EQU #C0
SCREEN_ADDR EQU #C000
ATTR_ADDR EQU SCREEN_ADDR+#1800
SHADOW_SCREEN_ADDR EQU SCREEN_ADDR

; MAP ZONE
mapSize=32;100; размер карты; а в RebelStar2 - 50x80

;  TILE ZONE
DEFINE tileSize 2; сколько знакомест в одном спрайте
DEFINE show_tile screen.show_tile_2x2; процедура показа спрайта
