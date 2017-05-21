	MODULE rpglang

MACRO rpglang.saveScriptAddr
	LD (rpglang.process+1), HL
ENDM

MACRO rpglang.init ptr
	LD HL, ptr
	rpglang.saveScriptAddr
ENDM

; �� ����� � HL - ����� ��������
process:
	LD HL, 0x0000
process_lp:
	LD a, (HL)
	INC HL
	cp _endByte; ��� ����� ����� ����� ��������� :)
	RET Z;
	OR a; script system
	jp z, script_system.enter
	dec a; graphic system
	jp z, graphic_system.enter
	dec a; input system
	jr z, input_system.enter
	dec a; sound system
	jp z, sound_system.enter
	dec a; gfx system
	jp z, gfx_system.enter
	dec a; gfx system
	JP z, rpg_system.enter
	jr process_lp

	ENDMODULE