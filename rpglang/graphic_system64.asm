	MODULE graphic_system

	; ������ ������� �� �������� ����������� � � Y
	MACRO PRINT_AT y,x,text_ptr; rPrintAT <Y>, <X>, <addr>
	defb graphic_system_num
	defb 0
	defb y
	defb x
	defw text_ptr
	ENDM

	; ����� ������� ���� ���������������� ��������� �� �����
	; ����� ������������ ����������� �� �������� ����� ( ������� =0 )
	; ������� � ������� �������� ������ ���� ���� � �������� �
init_font:
	LD ( Text.PR_64_L+1),A
  LD ( Text.PR_64_R+1),A
  RET

enter:
	rLDAor
	JR Z, cmd_0
	;DEC A
	;JR Z, cmd_1
	;DEC A
	;JR Z, cmd_2
	;DEC A
	;JR Z, cmd_3
	jp rpglang.process_lp

cmd_0:
	rLBC
	rLDE
	;LD HL,posx*256+posy
  ;LD DE,text
  PUSH HL
  PUSH BC
  POP HL
  CALL Text.print_64at
	POP HL
	jp rpglang.process_lp

	ENDMODULE
