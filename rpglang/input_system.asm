	MODULE input_system

	MACRO WAIT_ANY_KEY
	defb input_system_num
	defb 0
	ENDM

; �� ����� HL - ��������� �� ������� �����,
; a - ����� �������
enter:
	rLDAor
;	LD A, (HL)
;	INC HL
;	XOR A
	JR Z, cmd_0
;	DEC A
	jp rpglang.process_lp

SYS_LAST_KEY equ 23560

cmd_0: ;WAIT_ANY_KEY
	PUSH HL
	ld hl,SYS_LAST_KEY  ; LAST K system variable.
	ld (hl),0           ; put null value there.
lp:
	HALT
	ld a,(hl)         	; new value of LAST K.
	cp 0                ; is it still zero?
	jr z,lp             ; yes, so no key pressed.
	POP HL
	jp rpglang.process_lp

	ENDMODULE
