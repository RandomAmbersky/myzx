	MODULE rpg_system

	MACRO rInitMap addr
	defb rpg_system_num
	defb 0
	defw addr
	ENDM

	MACRO rInitChars addr
	defb rpg_system_num
	defb 0
	defw addr
	ENDM

enter: rLDAor
	;JR Z, cmd_0
	;DEC A
	;JR Z, cmd_1
	jp rpglang.process_lp

	ENDMODULE
