	MODULE script_system
	
	MACRO rJP  addr; jJP <addr>
	defb script_system_num
	defb 0
	defw addr
	ENDM

enter: rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	jp rpglang.process_lp

cmd_0: ; ================ rJP
	LD DE, (HL)
	PUSH DE
	POP HL
	JP rpglang.process_lp

cmd_1:
	JP rpglang.process_lp

/*
 ; ================ rRandomScreen
	PUSH HL
	LD (old_sp+1), SP
LOOP0:
	LD SP, #5800
       	LD B,12
LOOP1:
	LD C,256
LOOP2:
	FastGalois16
        PUSH HL

    	DEC C
    	JR NZ,LOOP2
    	DEC B
    	JR NZ,LOOP1
old_sp:
	LD SP, #0000
	POP HL

	JP rpglang.process_lp
*/
	ENDMODULE