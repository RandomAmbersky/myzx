	MODULE input_system

	MACRO WAIT_ANY_KEY
	defb input_system_num
	defb 0
	ENDM

	;include "rpglang/keyboard.asm"

enter:
	rLDAor
	JR Z, cmd_0
;	DEC A
	jp rpglang.process_lp

cmd_0: ;// WAIT_ANY_KEY
	LD( rpglang.process+1), HL
cmd_0_loop:
		HALT
		XOR A
		IN A,(0xfe)
		CPL
		and 31
		JR Z, cmd_0_loop
		jp rpglang.process

	ENDMODULE
