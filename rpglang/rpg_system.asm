	MODULE rpg_system

	MACRO rInitMap addr
	defb rpg_system_num
	defb 0
	defw addr
	ENDM

	MACRO rInitTiles addr
	defb rpg_system_num
	defb 1
	defw addr
	ENDM

	/*MACRO rInitEncounters addr
	defb rpg_system_num
	defb 2
	defw addr
	ENDM

	MACRO rInitChars addr
	defb rpg_system_num
	defb 3
	defw addr
	ENDM*/

	MACRO rShowMapAt xy
	defb rpg_system_num
	defb 2
	defw xy
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

cmd_0: ; ================ rInitMap
	rLDE
	LD (Map.mapArray), DE
	JP rpglang.process_lp

cmd_1: ; ================ rInitTiles
	rLDE
	LD (Tiles16.sprArray), DE
	JP rpglang.process_lp

cmd_2:
	rLDE
	PUSH HL
	CALL Map.look_at
	CALL Map.showMap
	POP HL
cmd_3:
	JP rpglang.process_lp

	ENDMODULE
