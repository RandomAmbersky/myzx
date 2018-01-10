	MODULE input_system

	MACRO WAIT_ANY_KEY
	defb input_system_num
	defb 0
	ENDM

	MACRO CURSOR_SCR_MOVE kuda; CURSOR_SCR_MOVE dir_up ; только в пределах экрана
	defb input_system_num
	defb 1
	defb kuda
	ENDM

	MACRO WAIT_NO_KEY; ждем пока все клавиши будут отжаты
	defb input_system_num
	defb 2
	ENDM

	MACRO CURSOR_SCR_INIT; показываем курсор первый раз - копируем содержимое под ним в буфер
	defb input_system_num
	defb 3
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
	JP Z, cmd_2
	DEC A
	JP Z, cmd_3
	;DEC A
	jp rpglang.process_lp

cmd_0: ;// WAIT_ANY_KEY
	call noKey
	call waitKey
	call noKey
	jp rpglang.process_lp

cmd_1: ;// CURSOR_SCR_MOVE
	PUSH HL
	LD DE, (curPos)
	CALL math.pos_scr; в DE - адрес на экране
	PUSH DE
	ScreenBuf.buf4_to_scr; восстанавливаем прежнее изображение под курсором
	POP DE; в DE - адрес на экране, он нам еще нужен
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
	DEC A
  JP M, rpglang.process_lp
  LD (curPos.y),A
	jp show_cursor
cursor_down:
	LD A, (curPos.y)
	INC A
	INC A
  CP scrHeight*2
	JP NC, rpglang.process_lp
	LD (curPos.y),A
	jp show_cursor
cursor_left:
	LD A, (curPos.x)
	DEC A
	JP M, rpglang.process_lp
	DEC A
	JP M, rpglang.process_lp
	LD (curPos.x),A
	jp show_cursor
cursor_right:
	LD A, (curPos.x)
	INC A
	INC A
	CP scrWidth*2
	JP NC, rpglang.process_lp
	LD (curPos.x),A
	/* DUP 300
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	EDUP */
show_cursor: ; в DE остался адрес на экране
	PUSH HL

	PUSH DE
	EX DE, HL; в HL у нас адрес на экране
	NOP
	call ScreenBuf.scr_to_buf4
	NOP
	POP DE; DE - адрес на экране
	/* PUSH HL
	PUSH HL
	PUSH HL */
	;LD HL, GUI_SET
	/* POP HL
	POP HL
	POP HL */
	;call ScreenBuf.buf4_to_scr
	;PUSH HL
	;PUSH DE
	;PUSH BC
	;call Tiles16.show_tile_on_map;HL - указатель на спрайт ;DE - экранный адрес
	;POP BC
	;POP DE
	;POP HL
	;call Tiles16.show_tile_on_map;HL - указатель на спрайт ;DE - экранный адрес
	POP HL
	jp rpglang.process_lp

cmd_2:
	call noKey
	jp rpglang.process_lp

cmd_3:
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
input_system_end:
	ENDMODULE
