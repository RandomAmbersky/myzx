	MODULE graphic_system
enter:
	LD A, (HL)
	INC HL
	jp rpglang.process_lp


	ENDMODULE