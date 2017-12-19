	MODULE script_system

	; ����������� ������� �� �����
	MACRO GOTO addr; jJP <addr>
	defb script_system_num
	defb 0
	defw addr
	ENDM

	; �������� 1/50 ������� * tms
	MACRO WAIT tms; <tms> 1/50 sec
	defb script_system_num
	defb 1
	defb tms
	ENDM

	; ������ FPS ����� �������
	MACRO FPS_CALC;
	defb script_system_num
	defb 2
	ENDM

	MACRO rScanKeys table_ptr; rScanKeys <table>
	defb script_system_num
	defb 3
	defw table_ptr
	ENDM

	MACRO rCALL script_ptr; вызов процедуры скрипта
	defb script_system_num
	defb 4
	defw script_ptr
	ENDM

	MACRO rExec code_ptr; вызов процедуры в кодах
	defb script_system_num
	defb 5
	defw code_ptr
	ENDM

enter: rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	DEC A
	JR Z, cmd_2
	DEC A
	JR Z, cmd_3
	DEC A
	JR Z, cmd_4
	DEC A
	JR Z, cmd_5
	jp rpglang.process_lp

cmd_0: ; ================ rJP
	LD DE, (HL)
	PUSH DE
	POP HL
	JP rpglang.process_lp

cmd_1: ; ================ rWait
	LD B, (HL)
	INC HL
_cmd1_loop
	HALT
	DJNZ _cmd1_loop
	JP rpglang.process_lp

cmd_2: ; ================ FPS_CALC
	PUSH HL
	LD A, (globaldata.frame_current); frame_current ����������
	LD L,A
	LD H,50
	CALL math.div_byte
	LD A,B
	CALL math.decbcd
	LD A,B
	ADD A,'0'
	LD (str_fps+0),A
	LD A,C
	ADD A,'0'
	LD (str_fps+1),A
	LD A,D
	ADD A,'0'
	LD (str_fps+2),A
	Text.print64at 0,0,str_fps

	LD A, (globaldata.frame_counter); frame_counter ����������  � ������� frame_current
	LD (globaldata.frame_current), A
	XOR A
	LD (globaldata.frame_counter), A; �������� ������� �������
	POP HL
	JP rpglang.process_lp

cmd_3: ; ================ scan keys
	rLDE
	PUSH HL
	/* LD HL,DE */
	PUSH DE
	POP HL
	call scanKeys; возвратились из scankeys, в DE - указатель на процедуру
	JR NZ, cmd_4_call; если флаг не 0 то клавиша есть
	POP HL
	JP rpglang.process_lp

cmd_4: ; ================ rCALL
	rLDE
	PUSH HL
cmd_4_call:
	PUSH DE
	POP HL
	;;LD DE, HL
	;LD HL, DE
	call rpglang.process_lp
	POP HL
	JP rpglang.process_lp

cmd_5: ; ================ rExec
	rLDE
	PUSH HL
	LD HL,DE
	CALL callHL
	POP HL
	JP rpglang.process_lp

callHL	jp (hl)

// честно стырено из движка Wanderers
scanKeys:
	ld a,(HL) ;//  загружаем первый байт
	and a // проверяем на 0
	ret z // возвращаем если 0
	inc hl // увеличиваем HL
	in a,(0xfe) // читаем значение
	and (hl) // сравниваем со вторым байтом
	inc hl   // увеличиваем указатель
	ld e,(hl)
	inc hl
	ld d,(hl) // запоминаем в DE указатель на процедуру
	inc hl    // увеличиваем HL
	jr nz,scanKeys
	ex de,hl
	or 2
	ret

/*cmd_3: ; ================ FPS_CLEAR
	XOR A
	LD (globaldata.frame_counter), A; �������� ������� �������
	JP rpglang.process_lp*/

str_fps: defb "000 fps",0

/*
 ; ================ rRandomScreen
	PUSH HL
	LD (old_sp+1), SP
LOOP0:
	LD SP, #5800
       	LD B,12
LOOP1:
	LD C,256
LOOP2:
	FastGalois16
        PUSH HL

    	DEC C
    	JR NZ,LOOP2
    	DEC B
    	JR NZ,LOOP1
old_sp:
	LD SP, #0000
	POP HL

	JP rpglang.process_lp
*/
	ENDMODULE
