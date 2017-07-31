	MODULE script_system

	; безусловный переход на адрес
	MACRO GOTO addr; jJP <addr>
	defb script_system_num
	defb 0
	defw addr
	ENDM

	; задержка 1/50 секунды * tms
	MACRO WAIT tms; <tms> 1/50 sec
	defb script_system_num
	defb 1
	defb tms
	ENDM

	; меряем FPS между кадрами
	MACRO FPS_CALC;
	defb script_system_num
	defb 2
	ENDM

	; очищаем счетчик FPS
	/*MACRO FPS_CLEAR
	defb script_system_num
	defb 3
	ENDM*/

enter: rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	DEC A
	JR Z, cmd_2
	/*DEC A
	JR Z, cmd_3*/
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
	LD A, (globaldata.frame_current); frame_current показываем
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

	LD A, (globaldata.frame_counter); frame_counter запоминаем  в будущей frame_current
	LD (globaldata.frame_current), A
	XOR A
	LD (globaldata.frame_counter), A; обнуляем счетчик фреймов
	POP HL
	JP rpglang.process_lp

/*cmd_3: ; ================ FPS_CLEAR
	XOR A
	LD (globaldata.frame_counter), A; обнуляем счетчик фреймов
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
