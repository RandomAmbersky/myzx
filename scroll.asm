
ADDR EQU 16415 ;����� � ��������  ������� �����  ������� ������,   �����  ���  ��  ������
	LD      A,0
	LD (23560),A ;�����   ��  �������  ������ ����� �������������� ��� �������
Start:
	LD   DE,TEXT ;�  ������� DE ������� ����� �� �������� ���������� �����.
 
NEXT_CHAR
	LD B,8 ;���������� ���������� ������� ������ �� ������ ���������� �������.
NEXT_PIXL
	HALT
	PUSH BC ;���������           ������� ����������� �����.
	LD HL,ADDR 
	LD B,8
NEXT_LINE
	PUSH BC
	LD      B,31
NEXT_BYTE
	RL      (HL)
	DEC     HL
	DJNZ NEXT_BYTE
	POP   BC 
	INC     H
	LD      A,31
	ADD     A,L
	LD      L,A
	DJNZ NEXT_LINE
	POP BC
	DJNZ   NEXT_PIXL

	LD A,(DE)
	OR A
	JR Z,Start
	PUSH DE
	LD HL,(23606)
	LD B,8
	LD D,0
	LD E,A   ;���   ����� ������� � ������� DE.
	RL E
	RL D
	RL E
	RL D
	RL E
	RL D
	ADD HL,DE
	LD DE,ADDR
NXTBYTCHR
	LD A,(HL)
	LD (DE),A
	INC HL
	INC D
	DJNZ NXTBYTCHR
	POP  DE
	INC DE
	JR NEXT_CHAR

TEXT DEFM "Hello world!                              "
	DEFB 0
