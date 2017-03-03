
mapSize=32;100; размер карты; а в RebelStar2 - 50x80

DEFINE tileFile "rebelstar.asm"
DEFINE mapFile "dummy_map.asm"
DEFINE persFile "character_list.asm"

DEFINE tileSize 2; сколько знакомест в одном спрайте
DEFINE show_tile screen.show_tile_2x2


STRUCT Point
y db 00
x db 00
ENDS
