	MODULE math
	
;   ��������� �������� ����� �� � � ���������� ������������� � ��������� BCD
;   ����� ������� �� ������ ����� SancheZ Survivesection
;   ������ ����������� ��������� �� 8
decbcd
    LD BC,0
_decbcd_1
    SUB 100
    JR C, _decbcd_2
    INC B
    JR _decbcd_1
_decbcd_2
    ADD A,100
_decbcd_3
    SUB 10
    JR C, _decbcd_4
    INC C
    JR _decbcd_3
_decbcd_4
    ADD A,10
    LD D,A
    RET

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
pos_scr:
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
    	OR   high SCREEN_ADDR
    	LD   D,A
    	RET

; ��������� ��������� ������ �� ������ �������
; ����: A - ����� �������
; ����� - DE - ����� ������
str_scr: //E-y
    	PUSH AF
    	AND #18
    	OR high SCREEN_ADDR
    	LD D,A
    	POP AF
    	AND 7
    	RRCA
    	RRCA
    	RRCA
    	LD E,A
    	RET


	ENDMODULE