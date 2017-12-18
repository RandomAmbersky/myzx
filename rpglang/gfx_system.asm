	MODULE gfx_system

	MACRO rRandomScreen
	defb gfx_system_num
	defb 0
	ENDM

	MACRO rBorder border; rBorder PEN_CYAN
	defb gfx_system_num
	defb 1
	defb border
	ENDM

	MACRO FaceBik

.xrnd ld hl,1       ; seed must not be 0

	  ld a,h
	  rra
	  ld a,l
	  rra
	  xor h
	  ld h,a
	  ld a,l
	  rra
	  ld a,h
	  rra
	  xor l
	  ld l,a
	  xor h
	  ld h,a

	  ld (.xrnd+1),hl

	  ENDM


	MACRO FastGalois16; � HL - �������� �� ������
FastGalois16: ld hl, #FFFF
	add   hl, hl         ; 11
	sbc   a         ; 4
	and   #BD         ; 7   instead of #BD, one can use #3F or #D7
	xor   l         ; 4
	ld   l, a         ; 4
	ld   (FastGalois16+1), hl      ; 16
	ld   a, h
        and   %10101010
        add   l         ; +4+7+4 => +15t overhead
	ENDM


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

; rnd �� ������ ���� Survivesection
	MACRO RND_Sanchez
		LD A,R
.RND_1
		LD E,0
		ADD A,E
		LD E,A
		ADD A,A
		ADD A,A
		ADD A,E
		ADD A,7
		LD (.RND_1+1), A
	ENDM

enter:	rLDAor
	JR Z, cmd_0;
	DEC A
	JR Z, cmd_1
	jp rpglang.process_lp

cmd_0: ; ================ rRandomScreen
	//HALT
	//DI
	PUSH HL
	;LD (old_hl+1), HL
	LD (old_sp+1), SP
LOOP0:
	LD SP, #5800
	LD B,12
LOOP1:
	LD C,#ff
LOOP2:
	//FastGalois16
	FaceBik
	;RND_ELITE
	;RND_Sanchez
  ;LD H,A
	;LD L,A
  ;RND_ELITE
  ;RND_Sanchez
	;LD L,A
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
	//EI
	JP rpglang.process_lp

cmd_1: ; ================ rBorder
	LD A, (HL)
	OUT (#FE), A
	INC HL
	JP rpglang.process_lp
	ENDMODULE
