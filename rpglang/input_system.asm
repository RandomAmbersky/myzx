	MODULE input_system

	MACRO WAIT_ANY_KEY
	defb input_system_num
	defb 0
	ENDM

; �� ����� HL - ��������� �� ������� �����,
; a - ����� �������
enter:
	LD A, (HL)
	INC HL
	XOR A
	JR Z, cmd_0
	DEC A
	jp rpglang.process_lp


cmd_0: ;rAnyKeyWait
	PUSH HL
	ld hl,23560         ; LAST K system variable.
	ld (hl),0           ; put null value there.
lp:	ld a,(hl)           ; new value of LAST K.
	cp 0                ; is it still zero?
	jr z,lp             ; yes, so no key pressed.
	POP HL
	jp rpglang.process_lp

	ENDMODULE
