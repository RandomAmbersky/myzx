ORG  #E000
  MODULE interrupt
interrupt_begin:
DEFS 257,#E1 ; � ALASMe ��������� 257 ���� ����� #81
int_init:
  DI
  LD   A,#E0
  LD   I,A
  IM   2
  EI
  RET
ORG  #E1E1
interrupt_routine:
  DI
  push af             ; preserve registers.
  push bc
  push de
  push hl
  push ix
  push iy
  LD HL, globaldata.frame_counter
  INC (HL)
return_routine:
  pop iy
  pop ix             ; restore registers.
  pop hl
  pop de
  pop bc
  pop af
  EI
  ret
interrupt_end
  ENDMODULE
