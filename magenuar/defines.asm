
; MAP ZONE
mapSize=32;100; размер карты; а в RebelStar2 - 50x80
;DEFINE mapFile "dummy_map.asm"
DEFINE mapFile "mage_map.asm"

;  TILE ZONE REBELSTAR
;DEFINE tileFile "rebelstar.asm"
;DEFINE tileSize 2; сколько знакомест в одном спрайте
;DEFINE show_tile screen.show_tile_2x2

;  TILE ZONE MAGE
DEFINE tileFile "mage_sprite.asm"
DEFINE tileSize 4; сколько знакомест в одном спрайте
DEFINE show_tile screen.show_tile_4x4

; CHARACTERS ZONE
DEFINE persFile "character_list.asm"
