DEVICE zxspectrum48
ORG #6000
; ------------- prog begin ---------------
_prog_start: jp main

	include "rpglang/defines.asm"

_core:
	include "rpglang/core/math.asm"
	include "rpglang/core/tiles16.asm"
	include "rpglang/core/screen_buf.asm"
	include "rpglang/core/scankeys.asm"
	include "rpglang/core/text68.asm"

_middle:
	include "rpglang/middle/map.asm"
	include "rpglang/middle/entities.asm"

_global:
	include "rpglang/global_data.asm"
	include "rpglang/global_routines.asm"
	include "rpglang/rpglang.asm"
	include "rpglang/graphic_system64.asm"
	include "rpglang/sound_system.asm"
	include "rpglang/gfx_system.asm"
	include "rpglang/rpg_system.asm"
	include "rpglang/script_system.asm"
	include "rpglang/input_system.asm"
main:
	;LD SP, #FFFF; а и фиг со стеком!
	;LD SP, #5800-1; а и фиг со стеком!
	;LD SP, STACK_BUFF
	;call routines.fill_scr_table
	;LD A, high p84_font
	;call graphic_system.init_font
	call interrupt.int_init
	call script_pre_init_asm;
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
	;ret
	/*DI
	HALT
	DUP 10
	NOP
	EDUP*/

_prog_end
; ------------- prog end ---------------
; ------------- data begin -------------
_data_start
	include "rpglang/system_data.asm"

LANG_SET:
	include "rpglang/data/lang_ru.asm"
GUI_SET:
	include "rpglang/data/gui.asm"
TILE_SET:
	;include "rpglang/data/rebelstar_spr.asm"
	include "rpglang/data/new_tiles.asm"
TILE_SET_END
MAP_SET:
	;include "rpglang/data/mage_map.asm"
MAP_SET_END
	include "rpglang/data/laboratory.asm"
ENCOUNTER_SET:
	include "rpglang/data/rebelstar_enc.asm"
SCRIPT_SET:
	include "rpglang/data/script.asm"

MY_HELLO: defb "HELLO!",0

	ORG (high $+1)*256
;p84_font:
;	incbin "p8_font.bin"
p68_font:
	;incbin "AONfont_revert.fnt"
	incbin "casa2_revert.fnt"

_data_end;
; ------------- data end ---------------

	include "rpglang/interrupt.asm"
_vt_end

;display "center_at_map", Map.center_at_map
display "prog: ", _prog_start, " ", _prog_end, " ", /D, _prog_end - _prog_start
display "data: ", _data_start, " ", _data_end, " ", /D, _data_end - _data_start
display "font addr: ", p68_font
display "interrupt_routine : ", interrupt.interrupt_begin, " ", interrupt.interrupt_end

;display "TILE_SET: ", TILE_SET
;display "TILE_SET_END: ", TILE_SET_END
;display "GUI_SET: ", GUI_SET
;display "MAP_SET: ", MAP_SET
;display "MAP_SET_END: ", MAP_SET_END

;display "calc_pos: ", Map.calc_pos
;display "show_tile_on_map: ", Tiles16.show_tile_on_map
;display "check_action: ", Entities.check_action
display "SET_ACTION_CELL: ", Entities.setActionCell

;display "CURSOR_SHOW_INFO: ", input_system.cmd_4

;display "show_cursor: ", input_system.show_cursor
;display "scr_to_buf4: ", ScreenBuf.scr_to_buf4

;display "show_cursor: ", input_system.show_cursor
;display "script_begin: ", script_begin
;display "input_system_end: ", input_system.input_system_end

display /D, _data_end-_prog_start, " size, ", /D, 0x10000-_data_end, " free"

SAVESNA "myzx.sna",_prog_start
SAVETAP "myzx.tap",_prog_start

/* //TRD NOT WORKED!!! )))
emptytrd "murk3326.trd"
savetrd "murk3326.trd", "DEMO.C", _prog_start, _vt_end-_prog_start
org 25000
inchob "demo.$B"
endb:
savetrd "murk3326.trd", "boot.B", 25000, endb-25000 */
