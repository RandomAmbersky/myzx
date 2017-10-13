MAIN:
  CALL CLS;
  DI
  HALT

CLS:
    LD HL,#4000; Очистим экран, заполним ярко-желтым INK (число 4 6H = 70,его можно изменять;
    LD DE,#4001; рассчитываетсятак:INK+PAPER*8+BRIGHT* 64 ++FLASH*128) и сделаем бордюр черным.
    LD BC,#1800
    LD (HL),L
    LDIR
    LD  BC,#02FF
    LD  (HL),#46
    LDIR
    XOR A
    OUT (#FE),A
    RET

INIT:
    CALL CLS
    LD HL, SCROLTEXT
    LD (COUNTLET), HL
    LD (POSLET), HL
    LD A, #80
    LD (WIDTH), A
    LD A, #02
    LD ()
