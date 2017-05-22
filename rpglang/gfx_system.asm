	MODULE gfx_system

	MACRO rRandomScreen
	defb gfx_system_num
	defb 0
	ENDM

/*
	MACRO FastGalois16
FastGalois16: ld hl, #FFFF
.SeedValue:      EQU   $-2
	add   hl, hl         ; 11
	sbc   a         ; 4
	and   #BD         ; 7   instead of #BD, one can use #3F or #D7
	xor   l         ; 4
	ld   l, a         ; 4
	ld   (.SeedValue), hl      ; 16
	ld   a, h
        and   %10101010
        add   l         ; +4+7+4 => +15t overhead
	ENDM
*/

	MACRO RND_ELITE
  		ld a, (RSEED)
  		ld E, a
  		ld a, (RSEED + 1)
  		ld (RSEED), a
  		add a, E
  		ld E, a
  		ld a, (RSEED + 2)
  		ld (RSEED + 1), a
  		add a, E
  		rlca
  		ld (RSEED + 2), a
	ENDM
RSEED defb 0, 0, 255

enter:	rLDAor
	JR Z, cmd_0;
	jp rpglang.process_lp

cmd_0: ; ================ rRandomScreen
	HALT
	PUSH HL
	;LD (old_hl+1), HL
	LD (old_sp+1), SP
LOOP0:
	LD SP, #5800
       	LD B,12
LOOP1:
	LD C,255
LOOP2:
	;FastGalois16
	RND_ELITE
        LD H,A
        ;LD L,A
        ;RND_ELITE
        LD L,A
        PUSH HL

    	DEC C
    	JR NZ,LOOP2
    	DEC B
    	JR NZ,LOOP1
old_sp:
	LD SP, #0000
;old_hl	
	;LD HL, #0000
	POP HL
	JP rpglang.process_lp

	ENDMODULE