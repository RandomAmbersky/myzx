ORG  #E000
  MODULE interrupt
interrupt_begin:
DEFS 257,#E1 ; в ALASMe заполняет 257 байт кодом #81
int_init:
  DI
  LD   A,#E0
  LD   I,A
  IM   2
  EI
  RET
frame_counter: defb 00
ORG  #E1E1
interrupt_routine:
  DI
  push af             ; preserve registers.
  push bc
  push hl
  push de
  push ix
  defb 00,00,00
return_routine:
  pop ix              ; restore registers.
  pop de
  pop hl
  pop bc
  pop af
  EI
  ret
interrupt_end
  ENDMODULE

;DISPLAY "--- interrupt end: ",$
