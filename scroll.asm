
ADDR EQU 16415 ;јдрес в экранной  области конца  бегуўей строки,   мен€€  его  ¬ы  можете
	LD      A,0
	LD (23560),A ;¬ыход   из  бегуўей  строки будет осуўествл€тьс€ при нажатии
Start:
	LD   DE,TEXT ;¬  регистр DE заносим адрес по которому расположен текст.
 
NEXT_CHAR
	LD B,8 ; оличество пиксельных сдвигов строки до печати следуёўего символа.
NEXT_PIXL
	HALT
	PUSH BC ;—охран€ем           счетчик предыдуўего цикла.
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
	LD E,A   ; од   буквы записан в регистр DE.
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
