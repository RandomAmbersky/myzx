; массив соответствия кода спрайта на карте типу энкаунтера
;cells_types_spr:
  ;dw cGround, cWater, cGreenBush

; описываем героя:
CHARS_SET:
Hero1: Entities.Hero 0,0, 10, 0, 0, tHeroName1
Hero2: Entities.Hero 1,1, 11, 0, 0, tHeroName2
  defb _endByte

PersonagesNum equ 2
