DEVICE zxspectrum48
ORG #8000
; ------------- prog begin ---------------
_prog_start: jp main

	include "rpglang/defines.asm"
	include "rpglang/math.asm"
	include "rpglang/global_data.asm"
	include "rpglang/rpglang.asm"
	include "rpglang/input_system.asm"
	include "rpglang/script_system.asm"
	include "rpglang/graphic_system.asm"
	include "rpglang/sound_system.asm"
	include "rpglang/gfx_system.asm"
	include "rpglang/rpg_system.asm"

main:
	rpglang.init script_begin
	jp rpglang.process
	ret

_prog_end
; ------------- prog end ---------------
; ------------- data begin ---------------
_data_start

script_begin:
	rFpsMeasureStart
	rRandomScreen
	;rKeyAnyWait
	rFpsMeasureEnd
	rJP script_begin
	defb _endByte

_data_end;
; ------------- data end ---------------

display "prog: ", _prog_start, " ", _prog_end
display "data: ", _data_start, " ", _data_end

display /D, $-_prog_start, " size, ", /D, 0x10000-$, " free"

SAVESNA "myzx.sna",_prog_start
