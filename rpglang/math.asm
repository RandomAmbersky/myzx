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

; вычисляем позицию адрес по позиции знакоместа
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

; вычисляем адресацию экрана по номеру строчки
; Вход: A - номер строчки
; Выход - DE - адрес экрана
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