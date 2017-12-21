	MODULE sound_system

	MACRO rPlayFX num
	defb sound_system_num
	defb 0
	defb num
	ENDM

	MACRO rPlayTweet num
	defb sound_system_num
	defb 1
	defb num
	ENDM

	MACRO rPlayVibr num
	defb sound_system_num
	defb 2
	defb num
	ENDM

	MACRO rPlayLaser num
	defb sound_system_num
	defb 3
	defb num
	ENDM

enter: rLDAor
	JR Z, cmd_0
	DEC A
	JR Z, cmd_1
	DEC A
	JR Z, cmd_2
	DEC A
	JR Z, cmd_3
	;DEC A
	;JR Z, cmd_4
	;DEC A
	;JR Z, cmd_5
	jp rpglang.process_lp

cmd_0:
	LD A, (HL)
	INC HL
	PUSH HL
	CALL explos
	POP HL
	JP rpglang.process_lp

cmd_1:
	LD A, (HL)
	INC HL
	PUSH HL
	CALL tweet
	POP HL
	JP rpglang.process_lp

cmd_2:
	LD A, (HL)
	INC HL
	PUSH HL
	CALL vibr
	POP HL
	JP rpglang.process_lp

cmd_3:
	LD A, (HL)
	INC HL
	PUSH HL
	CALL laser
	POP HL
	JP rpglang.process_lp

/*
snd:
	LD    B,10        ;количество циклов
	LD    HL,300      ;начальная частота звучания
	LD    DE,8        ;длительность звука
snd1:
	PUSH  BC
	PUSH  DE
	PUSH  HL
	CALL  949
	POP   HL
	POP   DE
	POP   BC
	DEC   HL          ;или INC HL
	DJNZ  snd1
	RET
*/

tweet:
  LD    B,100 ; длительность
  ;LD A,(23624)   ;определение цвета бордюра
  ;AND #38
  ;RRA
  ;RRA
  ;RRA
  LD A,7
  DI
TWEET1 XOR 16          ;переключение 4-го бита
       OUT (254),A
       PUSH BC
       DJNZ $           ;цикл задержки
       POP BC
       DJNZ TWEET1
       EI
       RET

vibr:  LD    H,100
       LD    E,10
       LD    B,4
       LD    L,1

        ;LD    A,(23624)
        ;AND   #38
        ;RRA
        ;RRA
        ;RRA
        ;LD    C,A
        DI
VIBR1  LD    D,E         ;продолжительность цикла спада (подъема)
VIBR2  LD    A,C
        XOR   16
        LD    C,A
        OUT   (254),A
        LD    A,H         ;изменение частоты звука
        ADD   A,L
        LD    H,A
VIBR3  DEC   A           ;цикл задержки
        JR    NZ,VIBR3
        DEC   D
        JR    NZ,VIBR2
        LD    A,L         ;смена направления изменения частоты
        NEG
        LD    L,A
        DJNZ  VIBR1
        EI
        RET

laser:
  LD    B,5
       LD    C,200
       LD    H,50
       LD    A,(23624)
       AND   #38
       RRA
       RRA
       RRA
       DI
LASER1 PUSH  BC
       LD    L,H
LASER2 XOR   16
       OUT   (254),A
       LD    B,H
       DJNZ  $
       INC   H           ;другой вариант - DEC H
       DEC   C
       JR    NZ,LASER2
       LD    H,L
       POP   BC
       DJNZ  LASER1
       EI
       RET

explos
  ; B - количество повторений эффекта
  ; D - задается длительность звучания
  ; E начальную среднюю частоту.
      LD    B,1
      LD    D,50
      LD    E,-1

			/* LD    B,1
      LD    D,10
      LD    E,200 */

      ;LD    B,2
      ;LD    D,35
      ;LD    E,100

 ;LD    A,(23624)
        ;AND   #38
        ;RRA
        ;RRA
        ;RRA
        ;LD    L,A
        DI
EXPL1  PUSH  BC
      	PUSH  DE
EXPL2  PUSH  DE
EXPL3  LD    B,E
        DJNZ  $           ;задержка
        LD    A,(BC)      ;в паре BC один из первых 256 адресов ПЗУ
        ;AND   16
        ;OR    L
        OUT   (254),A
        INC   C
        DEC   D
        JR    NZ,EXPL3
        POP   DE
       ; Изменение высоты шума (понижение среднего тона;
       ;  если заменить на DEC E, тон будет наоборот повышаться)
       INC   E
       DEC   D
       JR    NZ,EXPL2
       POP   DE
       POP   BC
       DJNZ  EXPL1       ;повторение всего эффекта
       EI
       RET

	ENDMODULE
