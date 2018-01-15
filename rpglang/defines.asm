_endByte equ #00; и низя никакой другой ибо используется в keyscan таблицах
;_endTable equ #00

;указатели направления
dir_up   EQU 0
dir_down EQU 1
dir_left  EQU 2
dir_right  EQU 3
; не используется но вдруг!!! ;)
dir_up_left EQU 4
dir_up_right EQU 5
dir_down_left EQU 6
dir_down_right EQU 7

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
;scrWidth equ 16
;scrHeight equ 12
scrWidth equ 15
scrHeight equ 11

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

	MACRO ADDA hr,lr
		add a,lr;  a = a + lr
		ld lr,a ; lr = a + lr
		adc a,hr ; a = a + lr + hr + (carry )
		sub lr; a = a + hr
		ld hr,a
	ENDM

	MACRO rLDA
		LD A, (HL)
		INC HL
	ENDM

	MACRO rLDAor
		LD A, (HL)
		INC HL
		OR A
	ENDM

	MACRO rLDE ;LD DE, (HL)
		LD E, (HL)
		INC HL
		LD D, (HL)
		INC HL
	ENDM

	MACRO rLBC ;LD BC, (HL)
		LD C, (HL)
		INC HL
		LD B, (HL)
		INC HL
	ENDM

	; первые резервные переменные
system_data.act_var equ 0; // переменная 0 - действие
  ;act_var equ 1; // переменная 1 что возвратили из скрипта
system_data.ret_var equ 2; // переменная 2 что возвратили из скрипта

	MACRO system_data.setVar var, val
    LD ( system_data.varsTab + var ), val
  ENDM

	MACRO system_data.getVar perem, var
    LD perem, ( system_data.varsTab + var )
  ENDM
