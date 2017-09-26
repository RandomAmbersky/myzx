DEVICE zxspectrum48
ORG #8000
; ------------- prog begin ---------------
_prog_start: jp main

	include "rpglang/defines.asm"

	include "rpglang/core/math.asm"
	include "rpglang/core/tiles16.asm"
	include "rpglang/core/scankeys.asm"

	include "rpglang/middle/map.asm"
	include "rpglang/middle/entities.asm"

	include "rpglang/global_data.asm"
	include "rpglang/rpglang.asm"
	include "rpglang/input_system.asm"
	include "rpglang/text.asm"
	include "rpglang/graphic_system64.asm"
	include "rpglang/sound_system.asm"
	include "rpglang/gfx_system.asm"
	include "rpglang/rpg_system.asm"
	include "rpglang/script_system.asm"

main:
	LD A, high p84_font
	call graphic_system.init_font
	call interrupt.int_init
	rpglang.start SCRIPT_SET
	;LD HL, TILE_SET
	;LD ( Tiles16.sprArray), HL
	;Tiles16.setTiles TILE_SET
	;Map.setMap MAP_SET

	/*LD DE, #0505
	LD A, #1*/
	;LD DE, #0000
	/*/Tiles16.showTile HL, #1*/
	;call Map.pos_to_addr
	;call Map.showMap
	;di
	;halt
	ret
	/*DI
	HALT
	DUP 10
	NOP
	EDUP*/

_prog_end
; ------------- prog end ---------------
; ------------- data begin -------------
_data_start

LANG_SET:
	include "rpglang/data/lang_ru.asm"
TILE_SET:
	include "rpglang/data/rebelstar_spr.asm"
MAP_SET:
	include "rpglang/data/mage_map.asm"
ENCOUNTER_SET:
	include "rpglang/data/rebelstar_enc.asm"
SCRIPT_SET:
	include "rpglang/data/script.asm"


MY_HELLO: defb "HELLO!",0

	ORG (high $+1)*256
p84_font:
	incbin "p8_font.bin"

_data_end;
; ------------- data end ---------------

	include "rpglang/interrupt.asm"

display "center_at_map", Map.center_at_map
display "prog: ", _prog_start, " ", _prog_end, " ", /D, _prog_end - _prog_start
display "data: ", _data_start, " ", _data_end, " ", /D, _data_end - _data_start
display "font addr: ", p84_font
display "interrupt_routine : ", interrupt.interrupt_begin, " ", interrupt.interrupt_end

display /D, _data_end-_prog_start, " size, ", /D, 0x10000-_data_end, " free"

SAVESNA "myzx.sna",_prog_start
