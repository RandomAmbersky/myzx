	MODULE math
	
;	��������� ������� H/L = B ( C - �������)
;	����� ������� �� ������ ����� SancheZ Survivesection
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

; ��������� ������� ����� �� ������� ����������
; DE - D-x, E-y
calc_pos_to_addr_DE:
    	LD A,E
    	AND  7
    	RRCA
    	RRCA
    	RRCA
    	ADD  A,D
    	LD   D,E
    	LD   E,A
    	LD   A,D
    	AND  #18
    	OR   SCREEN_ADDR_H
    	LD   D,A
    	RET

; ��������� ��������� ������ �� ������ �������
; ����: A - ����� �������
; ����� - DE - ����� ������
calc_str_begin_to_addr: //E-y
    	PUSH AF
    	AND #18
    	OR SCREEN_ADDR_H
    	LD D,A
    	POP AF
    	AND 7
    	RRCA
    	RRCA
    	RRCA
    	LD E,A
    	RET


	ENDMODULE