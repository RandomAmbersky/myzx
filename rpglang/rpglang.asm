	MODULE rpglang
init:
	ret

; на входе в HL - адрес скриптов
process:
	LD (globaldata.scriptAddr), HL
	ret

	ENDMODULE