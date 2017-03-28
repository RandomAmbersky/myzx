  MODULE shadowscreen

show:
  ld hl, SHADOW_SCREEN_ADDR
  ld de, REAL_SCREEN_ADDR

copy_to_buf:
  ld bc, SCREEN_TOTAL_SIZE
copy_to_buf_loop:
  DUP 64
  ldi
  EDUP
  jp pe, copy_to_buf_loop	; parity flag becomes 0 when BC=0
  RET

  ENDMODULE
