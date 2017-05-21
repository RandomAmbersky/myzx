	MODULE script_system
	
	; безусловный переход на адрес
	MACRO rJP addr; jJP <addr>
	defb script_system_num
	defb 0
	defw addr
	ENDM

	; задержка 1/50 секунды * tms
	;MACRO rWait tms; <tms> 1/50 sec
	;defb script_system_num
	;defb 1
	;defw tms
	;ENDM

	; начало очередного шага цикла (для замера FPS)
	MACRO rFpsMeasureStart; 
	defb script_system_num
	defb 2
	ENDM

	; конец очередного шага цикла (для замера FPS)
	MACRO rFpsMeasureEnd
	defb script_system_num
	defb 3
	ENDM

enter: rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	DEC A
	JR Z, cmd_2
	DEC A
	JR Z, cmd_3
	jp rpglang.process_lp

cmd_0: ; ================ rJP
	LD DE, (HL)
	PUSH DE
	POP HL
	JP rpglang.process_lp


cmd_1: ; ================ rWait
	JP rpglang.process_lp


cmd_2: ; ================ rFpsMeasureStart
	XOR A
	LD (globaldata.frame_counter), A; обнуляем счетчик фреймов
	JP rpglang.process_lp


cmd_3: ; ================ rFpsMeasureEnd
	PUSH HL
	LD A, (globaldata.frame_current)
	LD L,A
	LD H,50
	CALL math.div_byte
	LD A, (globaldata.frame_counter)
	LD (globaldata.frame_current), A
	POP HL
	JP rpglang.process_lp

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