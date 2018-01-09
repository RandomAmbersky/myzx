	MODULE input_system

	MACRO WAIT_ANY_KEY
	defb input_system_num
	defb 0
	ENDM

	MACRO CURSOR_SCR_MOVE dir; CURSOR_SCR_MOVE dir_up ; только в пределах экрана
	defb input_system_num
	defb 1
	defb dir
	ENDM

	MACRO WAIT_NO_KEY; ждем пока все клавиши будут отжаты
	defb input_system_num
	defb 2
	ENDM

	;include "rpglang/keyboard.asm"
curPos Point 0,0
old_curPos Point 0,0

enter:
	rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	DEC A
	JR Z, cmd_2
	;DEC A
	jp rpglang.process_lp

cmd_0: ;// WAIT_ANY_KEY
	call noKey
	call waitKey
	call noKey
	jp rpglang.process_lp

cmd_1: ;// CURSOR_SCR_MOVE
	PUSH HL
	LD DE, curPos
	CALL math.pos_scr; в DE - адрес на экране
	EX HL, DE
	ScreenBuf.scr_to_buf4; копируем прежнее место под курсором
	POP HL
	rLDAor ;//dir_up
	JR Z, cursor_up
	DEC A
	JR Z, cursor_down
	DEC A
	JR Z, cursor_left
	DEC A
	JR Z, cursor_right
	jp rpglang.process_lp;  что-то непонятное пришло
cursor_up:
  LD A, (curPos.y)
  DEC A
  JP M, rpglang.process_lp
  LD (curPos.y),A
	jp show_cursor
cursor_down:
	LD A, (curPos.y)
	INC A
	JP M, rpglang.process_lp
	LD (curPos.y),A
	jp show_cursor
cursor_left:
	LD A, (curPos.x)
	DEC A
	JP M, rpglang.process_lp
	LD (curPos.x),A
	jp show_cursor
cursor_right:
	LD A, (curPos.x)
	INC A
	JP M, rpglang.process_lp
	LD (curPos.x),A
	;jp rpglang.process
show_cursor:
	ScreenBuf.buf4_to_scr
	jp rpglang.process_lp

cmd_2:
	/* HALT
	XOR A
	IN A,(0xfe)
	CPL
	and 31
	JR NZ, cmd_2 */
	call noKey
	jp rpglang.process_lp

waitKey:
	halt
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr z,waitKey
	ret

noKey
	halt
	xor a
	in a,(0xfe)
	cpl
	and 31
	jr nz,noKey
	ret

	ENDMODULE
