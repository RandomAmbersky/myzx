MODULE math

;   процедура перевода числа из А в десятичное представление в регистрах BCD
;   често стырена из сорцов демки SancheZ Survivesection
;   убрано последующее умножение на 8
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

; вычисляем адрес по позиции знакоместа
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

; вычисляем адрес в памяти по номеру строчки экрана
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

; процедура пересчета адреса в экранной области
; в адрес в области атрибутов
; Вход: DE - адрес в экранной области
; Выход: DE - адрес в области атрибутов
addr_to_attr:
	LD A,D
	AND #18
	RRCA
	RRCA
	RRCA
	ADD A,ATTR_ADDR/#100
	LD D,A
	RET

; перемещаемся на 1 линию в знакоместе ниже
; Вход: DE- экранный адрес
; Выход: DE - экранный адрес
down_line:
    INC D
    LD A,D
    AND 7
    RET NZ
    LD A,E
    ADD A,#20
    LD E,A
    RET C
    LD A,D
    SUB 8
    ;ADD A,-8
    LD D,A
    RET

; стырено из Wanderers SamStyle
; в a - rnd
getRnd	push hl
radr	ld hl,0
		inc hl
		ld a,h
		and 0x3f
		ld h,a
		ld (radr+1),hl
		ld a,r
		xor (hl)
		pop hl
		ret

ENDMODULE
