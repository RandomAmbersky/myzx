_endByte equ #ff

;system
;0 - script system
;1 - graphic system
;2 - input system
;3 - sound system
;4 - gfx system
;5 - rpg system

script_system_num equ 1
graphic_system_num equ 2
input_system_num equ 3
sound_system_num equ 4
gfx_system_num equ 5
rpg_system_num equ 6

SCREEN_ADDR equ #4000
ATTR_ADDR EQU SCREEN_ADDR+#1800

mapSize equ 32
scrWidth equ 16
scrHeight equ 12

STRUCT Point
y db 0
x db 0
ENDS

PEN_BLACK equ 0
PEN_BLUE equ 1
PEN_RED equ 2
PEN_PURPLE equ 3
PEN_GREEN equ 4
PEN_CYAN equ 5
PEN_YELLOW equ 6
PEN_WHITE equ 7

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
