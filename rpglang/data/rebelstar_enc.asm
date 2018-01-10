
CELL_TYPES:
Cell_Type_Empty:    Entities.CellType Empty_cell_name,    0000
Cell_Type_Floor:    Entities.CellType Floor_cell_name,    0000
Cell_Type_Computer: Entities.CellType Computer_cell_name, 0000
Cell_Type_Door:     Entities.CellType Door_cell_name,     0000
Cell_Type_Wall:     Entities.CellType Wall_cell_name,     0000
Cell_Type_Ballon:   Entities.CellType Ballon_cell_name,   0000

;CellType2: Entities.CellType 0,0,tHeroName1
;CellType3: Entities.CellType 0,0,tHeroName1
;CellType4: Entities.CellType 0,0,tHeroName1

;CELL_TABLE:
;Cell_Empty: Entities.Cell Cell_Type_Empty, 0,0
/* Cell2: Entities.Cell 0,0
Cell3: Entities.Cell 0,0
Cell4: Entities.Cell 0,0 */

; массив соответствия кода спрайта на карте типу энкаунтера
;cells_types_spr:
  ;dw cGround, cWater, cGreenBush

; позиция Y,X !!!

/* pos Point 0,0 ; позиция на карте
sprite db 00; спрайт
ground db 00; на чем стоит
flags db 00; признаки-флаги
name_p dw #0000 */

PersonagesNum equ 1
; описываем героя:
CHARS_SET:
;Hero1: Entities.Hero 31,31, 9, 0, 0, tHeroName1
;13-31
Hero2: Entities.Hero 1,14, 9, 0, 0, tHeroName2
;Hero3: Entities.Hero 22,22, 12, 0, 0, tHeroName2
;defb _endByte
