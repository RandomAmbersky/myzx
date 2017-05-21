DEVICE zxspectrum48
ORG #8000
; ------------- prog begin ---------------
_prog_start: jp main

	include "rpglang/defines.asm"
	include "rpglang/math.asm"
	include "rpglang/text.asm"
	include "rpglang/global_data.asm"
	include "rpglang/rpglang.asm"
	include "rpglang/input_system.asm"
	include "rpglang/script_system.asm"
	include "rpglang/graphic_system.asm"
	include "rpglang/sound_system.asm"
	include "rpglang/gfx_system.asm"
	include "rpglang/rpg_system.asm"

main:
	LD HL, p84_font
	LD A, H
	;LD A, (high p84_font)
	call Text.setFont64
	Text.print64 12, MY_HELLO
	;rpglang.init script_begin
	;jp rpglang.process
	;ret
	DI
	HALT

	DUP 10
	NOP
	EDUP

_prog_end
; ------------- prog end ---------------
; ------------- data begin ---------------

_data_start

MY_HELLO: defb "HELLO hello ПРИВЕТ привет",0

script_begin:
	rFpsMeasureStart
	;rRandomScreen
	rKeyAnyWait
	;rFpsMeasureEnd
	rJP script_begin
	defb _endByte

	ORG (high $+1)*256 // так делается выравнивание по старшему адресу :))
p84_font:
	incbin "p8_font.bin"

_data_end;
; ------------- data end ---------------

display "prog: ", _prog_start, " ", _prog_end
display "data: ", _data_start, " ", _data_end
display "font addr: ", p84_font
display "font addr: ", (high p84_font)

display /D, $-_prog_start, " size, ", /D, 0x10000-$, " free"

SAVESNA "myzx.sna",_prog_start
