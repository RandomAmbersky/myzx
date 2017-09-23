_endByte equ #ff

;system
;0 - script system
;1 - graphic system
;2 - input system
;3 - sound system
;4 - gfx system
;5 - rpg system

script_system_num equ 0
graphic_system_num equ 1
input_system_num equ 2
sound_system_num equ 3
gfx_system_num equ 4
rpg_system_num equ 5

SCREEN_ADDR equ #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

mapSize equ 32
scrWidth equ 16
scrHeight equ 12

STRUCT Point
y db 0
x db 0
ENDS

	MACRO MAP_SHOW_TILE
		call Tiles16.show_tile
	ENDM

	MACRO rLDAor
		LD A, (HL)
		INC HL
		OR A
	ENDM

	MACRO rLDE
		LD DE, (HL)
		INC HL
		INC HL
	ENDM

	MACRO rLBC
		LD BC, (HL)
		INC HL
		INC HL
	ENDM
