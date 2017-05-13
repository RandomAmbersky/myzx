	MODULE script_system

sysnum	equ 0x0; номер подсистемы
	
	MACRO rJP
	defb script_system.sysnum
	defb 0
	ENDM

	MACRO rRandomScreen
	defb script_system.sysnum
	defb 1
	ENDM

	MACRO FastGalois16
FastGalois16: ld hl, #FFFF
.SeedValue:      EQU   $-2
	add   hl, hl         ; 11
	sbc   a         ; 4
	and   #BD         ; 7   instead of #BD, one can use #3F or #D7
	xor   l         ; 4
	ld   l, a         ; 4
	ld   (.SeedValue), hl      ; 16
	ENDM

enter:
	LD A, (HL)
	INC HL
	OR A
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	jp rpglang.process_lp

cmd_0: ; ================ rJP
	LD DE, (HL)
	INC HL
	INC HL
	JP rpglang.process_lp


cmd_1: ; ================ rRandomScreen
	;DI
	PUSH HL
	LD (old_sp+1), SP
LOOP0:
	LD SP, #5800
	;call FastGalois16
	;LD HL,#0000
       	;LD DE,#4000
       	;LD BC,#1B00
       	;LDIR
       	LD B,12
LOOP1:
	LD C,256
LOOP2:

	;call FastGalois16
	FastGalois16
    	;LD A, (SEED_A)
    	;LD D,A
    	;LD E,A
        PUSH HL

    	DEC C
    	JR NZ,LOOP2
    	DEC B
    	JR NZ,LOOP1
    	;HALT
    	;JR LOOP0
old_sp:
	LD SP, #0000
	POP HL
	;EI
	JP rpglang.process_lp




	;ld   a, h
	;and   %10101010
	;add   l         ; +4+7+4 => +15t overhead
	ret            ; 10 => 10+11+4+7+4+4+16 + 10 = 66t

	ENDMODULE