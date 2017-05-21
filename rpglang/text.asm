  MODULE Text

  MACRO Text.print64 pos,text
    LD A,pos
    LD DE,text
    CALL Text.print_64
  ENDM

  MACRO Text.printNext text
    LD DE, text
    CALL Text.PRT_64
  ENDM

  MACRO Text.print64at posx,posy,text
    LD HL,posx*256+posy
    LD DE,text
    CALL Text.print_64at
  ENDM

; в А - старший байт адреса шрифта ( напр. #C000 -> #C0 )
; Шрифт должен быть расположен по "ровному" адресу к сожалению
setFont64:
  LD ( PR_64_L+1),A
  LD ( PR_64_R+1),A
  RET

print_64at
  PUSH DE
  PUSH HL
  POP DE
  CALL math.calc_pos_to_addr_DE
  PUSH DE
  POP HL
  POP DE
  CALL PRT_64
  RET

print_64
    PUSH DE
    CALL math.calc_str_begin_to_addr
    PUSH DE
    POP HL
    POP DE
    CALL PRT_64
    RET

  ; ������� ������ 64 ������� � ������
  ; ���������� ����� �� ���������� ������� � ����������
  ; ( Swap bytes H->L � FONTER2 )

  //DEFINE FONT64h #00

PRT_64
          LD A,(DE)
          AND A
          RET Z
          CALL PR_64_L
          INC DE
          LD A,(DE)
          AND A
          RET Z
          CALL PR_64_R
          INC DE
          JR PRT_64

PR_64_L LD B,00
          LD C,A
          DUP 7
          LD A,(BC)
          AND #F0
          LD (HL),A
          INC H
          INC B
          EDUP
          LD A,(BC)
          AND #F0
          LD (HL),A
          LD A,H
          SUB #07
          LD H,A
          RET

PR_64_R LD B,00
          LD C,A
          DUP 7
          LD A,(BC)
          AND #0F
          OR (HL)
          LD (HL),A
          INC H
          INC B
          EDUP
          LD A,(BC)
          AND #0F
          OR (HL)
          LD (HL),A
          LD A,H
          SUB #07
          LD H,A
          INC L
          RET

  ENDMODULE
