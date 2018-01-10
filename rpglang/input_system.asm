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
	;jp show_cursor
	/* DUP 300
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	jp rpglang.process
	EDUP */
show_cursor:
	PUSH HL
	CALL buf_and_show_cursor
	POP HL
	jp rpglang.process_lp

cmd_2:
	call noKey
	jp rpglang.process_lp

cmd_3: ; ==== CURSOR_SCR_INIT
	PUSH HL
	CALL cursor_scr_center
	POP HL
	jp rpglang.process_lp

cursor_scr_center:
	LD DE, #0e0a
	LD (curPos), DE
	LD (old_curPos), DE
	CALL and_show_cursor
	RET

buf_and_show_cursor:
	LD DE, (old_curPos); старая позиция
	CALL math.pos_scr; в DE - адрес на экране
	ScreenBuf.buf4_to_scr; восстанавливаем прежнее изображение под курсором
	LD DE, (curPos)
	LD (old_curPos), DE
and_show_cursor:
	CALL math.pos_scr; в DE - адрес на экране
	PUSH DE
	EX DE, HL
	CALL ScreenBuf.scr_to_buf4
	POP DE
	LD HL, GUI_SET
	CALL Tiles16.show_tile_on_map;HL - указатель на спрайт ;DE - экранный адрес */
	RET

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
