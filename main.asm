DEVICE zxspectrum48
ORG #8000
; ------------- prog begin ---------------
_prog_start:

	include "rpglang/defines.asm"

	call rpglang.init
	LD HL, script_begin
	call rpglang.process
	ret

	include "rpglang/rpglang.asm"

_prog_end
; ------------- prog end ---------------
; ------------- data begin ---------------
_data_start

	include "rpglang/globaldata.asm"

script_begin:
	_endByte;

_data_end;
; ------------- data end ---------------

display "prog: ", _prog_start, " ", _prog_end
display "data: ", _data_start, " ", _data_end

display /D, $-_prog_start, " size, ", /D, 0x10000-$, " free"

SAVESNA "myzx.sna",_prog_start
