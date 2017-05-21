	MODULE math
	
;	процедура деления H/L = B ( C - остаток)
;	често стырена из сорцов демки SancheZ Survivesection
div_byte 
	LD BC, #0800
	LD D,0
_div_byte_1
	RL H
	LD A,C
	RLA
	SUB L
	JR NC,_div_byte_2
	ADD A,L
_div_byte_2
	LD C,A
	CCF
	RL D
	DJNZ _div_byte_1
	LD B,D
	RET

	ENDMODULE