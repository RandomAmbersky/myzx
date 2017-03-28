  MODULE math

; Вход: HL, DE, A
; Выход: HL = HL + DE * A
; B=0 :)
  MACRO hl_add_de_mul_a_size
    LD B, A
    .loop_get_enc
    ADD HL, DE
    DJNZ .loop_get_enc
  ENDM

  ENDMODULE
