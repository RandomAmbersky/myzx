DEVICE zxspectrum48
ORG #8000
; ------------- prog begin ---------------
_prog_start: jp main

	include "rpglang/defines.asm"
	include "rpglang/math.asm"
	include "rpglang/global_data.asm"
	include "rpglang/rpglang.asm"
	include "rpglang/input_system.asm"
	include "rpglang/text.asm"
	include "rpglang/graphic_system.asm"
	include "rpglang/sound_system.asm"
	include "rpglang/gfx_system.asm"
	include "rpglang/rpg_system.asm"
	include "rpglang/script_system.asm"

main:
	LD A, high p84_font
	call graphic_system.init_font
	call interrupt.int_init
	rpglang.start script_begin
	ret
LAST_KEY equ 23560

wait_key: ;WAIT_ANY_KEY
		PUSH HL
		ld hl,LAST_KEY  ; LAST K system variable.
		ld (hl),0           ; put null value there.
lp_key:
		ld a,(hl)         	; new value of LAST K.
		cp 0                ; is it still zero?
		jr z,lp_key             ; yes, so no key pressed.
		POP HL

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

MY_HELLO: defb "HELLO!",0

script_begin:
	rRandomScreen
	;PRINT_AT 10,10, MY_HELLO
	;FPS_CALC
	;WAIT 1
	WAIT_ANY_KEY
	GOTO script_begin
	defb _endByte

	ORG (high $+1)*256 // ��� �������� ������������ �� �������� ������ :))
p84_font:
	incbin "p8_font.bin"

_data_end;

	include "rpglang/interrupt.asm"

; ------------- data end ---------------

display "prog: ", _prog_start, " ", _prog_end, " ", /D, _prog_end - _prog_start
display "data: ", _data_start, " ", _data_end, " ", /D, _data_end - _data_start
display "font addr: ", p84_font
display "interrupt_routine : ", interrupt.interrupt_begin, " ", interrupt.interrupt_end
//display "globaldata.frame_current ", globaldata.frame_current
display "MY_HELLO ", script_system.cmd_2

display /D, _data_end-_prog_start, " size, ", /D, 0x10000-_data_end, " free"

SAVESNA "myzx.sna",_prog_start
