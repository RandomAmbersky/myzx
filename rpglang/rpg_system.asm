	MODULE rpg_system

	MACRO rpg.InitMap addr
	defb rpg_system_num
	defb 0
	defw addr
	ENDM

	MACRO rpg.InitTiles addr
	defb rpg_system_num
	defb 1
	defw addr
	ENDM

	MACRO rShowMapAt xy
	defb rpg_system_num
	defb 2
	defw xy
	ENDM

	MACRO rShowMap
	defb rpg_system_num
	defb 3
	ENDM

	MACRO rpg.InitEntities addr
	defb rpg_system_num
	defb 4
	defw addr
	ENDM

	MACRO rpg.InitChars addr
	defb rpg_system_num
	defb 5
	defw addr
	ENDM

	MACRO rpg.NextChar
	defb rpg_system_num
	defb 6
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
	DEC A
	JR Z, cmd_6
	jp rpglang.process_lp

cmd_0: ; ================ rInitMap
	rLDE
	LD (Map.mapArray), DE
	JP rpglang.process_lp

cmd_1: ; ================ rInitTiles
	rLDE
	LD (Tiles16.sprArray), DE
	JP rpglang.process_lp

cmd_2: ; =============== rShowMapAt
	rLDE
	PUSH HL
	CALL Map.calc_pos
	CALL Map.showMap
	POP HL
	JP rpglang.process_lp

cmd_3: ; =============== rShowMap
		;rLDE
		PUSH HL
		CALL Map.look_at_map
		CALL Map.showMap
		POP HL
		JP rpglang.process_lp

cmd_4: ; =============== InitEntities (?)
	rLDE
	PUSH HL
	;CALL Entities.init
	POP HL
	JP rpglang.process_lp

cmd_5:
	rLDE
	PUSH HL
	LD HL, DE
	CALL Entities.initChars
	POP HL
	JP rpglang.process_lp

cmd_6: ; =============== rpg.NextChar - нафига? ведь все делается через rCALL прекрасно :)
		PUSH HL
		CALL Entities.nextChar
		JR NZ, next_char_exit
		CALL Entities.firstChar
next_char_exit:
		CALL Entities.lookChar
		POP HL
		JP rpglang.process_lp

	ENDMODULE
