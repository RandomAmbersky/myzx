	MODULE rpglang
init:
	ret

; �� ����� � HL - ����� ��������
process:
	LD (globaldata.scriptAddr), HL
	ret

	ENDMODULE