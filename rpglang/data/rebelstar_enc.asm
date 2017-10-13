; массив соответствия кода спрайта на карте типу энкаунтера
;cells_types_spr:
  ;dw cGround, cWater, cGreenBush

; позиция Y,X !!!

; описываем героя:
CHARS_SET:
Hero1: Entities.Hero 31,31, 10, 0, 0, tHeroName1
Hero2: Entities.Hero 10,10, 11, 0, 0, tHeroName2
Hero3: Entities.Hero 22,22, 12, 0, 0, tHeroName2
  defb _endByte

PersonagesNum equ 3
