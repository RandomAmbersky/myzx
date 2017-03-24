
DEVICE zxspectrum48
org #7000;
 ;include "./magenuar/main.asm"

;include "murkn/main.asm"

; пример вызова процедуры
/*
prg_start:

		ld	hl,string_01								; строка string_01
		ld	b,5									; строка экрана
		ld	c,8									; столбец экрана
		call	print64
		ret

string_01	defb	17
defm    '-= HELLO WORLD =-'

; печать строки текста шрифтом 4х8 с атрибутами
; вход: hl=адрес текста строки с количеством и кодами символов, b=строка экрана (0..23), c=столбец экрана (0..63)
; выход: нет

print64		ld	a,(hl)
		and	a
		ret	z

		push	hl
		call	calc_addr_attr
		ld	a,(attr_screen)
		ld	(hl),a
		pop	hl

		call	calc_addr_scr

		ld	a,(half_tile_screen)
		bit	0,a
		ld	a,(hl)
		jp	nz,print64_4

print64_3       push    af

		push	hl
		call	calc_addr_attr
		ld	a,(attr_screen)
		ld	(hl),a
		pop	hl

                inc     hl
                push    hl

                ld      a,(hl)
		sub	32
		ld	l,a
		ld	h,0
		add	hl,hl
		ld	c,l
		ld	b,h
		add	hl,hl
		add	hl,bc
                ld      bc,font64
                add     hl,bc

                push    de

                ld      b,6
		xor	a
		ld	(de),a
print64_1       inc     d
                ld      a,(hl)
		and	#f0
                ld      (de),a
                inc     hl
                djnz    print64_1

		inc	d
		xor	a
		ld	(de),a

		ld	a,1
		ld	(half_tile_screen),a

                pop     de
                pop     hl
                pop     af

                dec     a
                ret     z

print64_4	push    af

                inc     hl
                push    hl

                ld      a,(hl)
		sub	32
		ld	l,a
		ld	h,0
		add	hl,hl
		ld	c,l
		ld	b,h
		add	hl,hl
		add	hl,bc
                ld      bc,font64
                add     hl,bc

                push    de

                ld      b,6
		xor	a
		ld	(de),a
print64_2       inc     d
                ld      a,(hl)
                and     #0f
                ld      c,a
                ld      a,(de)
                or      c
                ld      (de),a
                inc     hl
                djnz    print64_2

		inc	d
		xor	a
		ld	(de),a

		ld	(half_tile_screen),a

                pop     de

		call	move_cr64

                pop     hl
                pop     af
                dec     a

                jp      nz,print64_3

                ret

; перемещение курсора после печати символа шрифтом 4х8
; вход: de=адрес знакоместа на экране
; выход: de=адрес нового знакоместа на экране, b=строка экрана, c=столбец экрана

move_cr64	inc	de

		ld	hl,col_screen
		inc	(hl)
		ld	a,(hl)

		cp	32
		ret	c

		xor	a
		ld	(half_tile_screen),a
		ld	(hl),a
		ld	c,a

		inc	hl
		inc	(hl)
		ld	a,(hl)
		ld	b,a

		cp	24
		jp	c,move_cr64_01

		ld	a,23
		ld	(hl),a
		ld	b,a

		push	bc
		call	scroll_up8
		pop	bc

move_cr64_01	call	calc_addr_scr

		ret

; расчет адреса знакоместа на экране
; вход: b=строка экрана, c=столбец экрана
; выход: de=адрес знакоместа на экране, b=строка экрана, c=столбец экрана

calc_addr_scr		ld      a,b
                	ld      d,a
                	rrca
                	rrca
                	rrca
                	and     a,224
                	add     a,c
                	ld      e,a
                	ld      a,d
                	and     24
                	or      64
                	ld      d,a
			ret

; расчет адреса атрибутов знакоместа на экране
; вход: b=строка экрана, c=столбец экрана
; выход: hl=адрес знакоместа на экране, b=строка экрана, c=столбец экрана

calc_addr_attr		ld	bc,(col_screen)
			ld	a,b
			rrca
			rrca
			rrca
			ld	l,a
			and	31
			or	88
			ld	h,a
			ld	a,l
			and	252
			or	c
			ld	l,a
			ret


; скроллинг экрана вверх на 8 пикселей (1 знакоместо) с атрибутами
; вход: нет
; выход: нет

scroll_up8		ld	hl,table_addr_scr
			ld	b,184

scroll_up8_01		push	bc

			ld	e,(hl)
			inc	hl
			ld	d,(hl)
			inc	hl

			push	hl

			ld	bc,14
			add	hl,bc
			ld	c,(hl)
			inc	hl
			ld	b,(hl)

			ld	h,b
			ld	l,c

			ld	bc,32
			ldir

			pop	hl
			pop	bc
			djnz	scroll_up8_01

			ld	b,8

scroll_up8_02		push	bc

			ld	e,(hl)
			inc	hl
			ld	d,(hl)
			inc	hl

			push	hl

			ld	h,d
			ld	l,e
			inc	de
			ld	(hl),0
			ld	bc,31
			ldir

			pop	hl
			pop	bc
			djnz	scroll_up8_02

			ld	de,#5800
			ld	hl,#5820
			ld	bc,736
			ldir

			ld	a,(de)

			ld	hl,#5ae0
			ld	de,#5ae1
			ld	(hl),a
			ld	bc,31
			ldir

			ret


; шрифт 4х8

font64

                    defb #00,#00,#00,#00,#00,#00	; 032  space
                    defb #44,#44,#44,#44,#00,#44	; 033  !
                    defb #AA,#AA,#00,#00,#00,#00	; 034  "
                    defb #AA,#EE,#AA,#AA,#EE,#AA	; 035  #
                    defb #44,#EE,#CC,#66,#EE,#44	; 036  $
                    defb #AA,#22,#44,#44,#88,#AA	; 037  %
                    defb #44,#AA,#44,#AA,#AA,#55	; 038  &
                    defb #22,#44,#00,#00,#00,#00	; 039  '
                    defb #22,#44,#44,#44,#44,#22	; 040  (
                    defb #44,#22,#22,#22,#22,#44	; 041  )
                    defb #00,#AA,#44,#AA,#00,#00	; 042  *
                    defb #00,#44,#EE,#44,#00,#00	; 043  +
                    defb #00,#00,#00,#00,#22,#44	; 044  ,
                    defb #00,#00,#EE,#00,#00,#00	; 045  -
                    defb #00,#00,#00,#00,#00,#44	; 046  .
                    defb #22,#22,#44,#44,#88,#88	; 047  /
                    defb #44,#AA,#AA,#AA,#AA,#44	; 048  0
                    defb #44,#CC,#44,#44,#44,#EE	; 049  1
                    defb #44,#AA,#22,#44,#88,#EE	; 050  2
                    defb #EE,#22,#44,#22,#22,#CC	; 051  3
                    defb #22,#66,#AA,#EE,#22,#22	; 052  4
                    defb #EE,#88,#CC,#22,#22,#CC	; 053  5
                    defb #66,#88,#CC,#AA,#AA,#44	; 054  6
                    defb #EE,#22,#44,#88,#88,#88	; 055  7
                    defb #44,#AA,#44,#AA,#AA,#44	; 056  8
                    defb #44,#AA,#AA,#66,#22,#CC	; 057  9
                    defb #00,#44,#00,#00,#44,#00	; 058  :
                    defb #00,#22,#00,#00,#22,#44	; 059  ;
                    defb #00,#22,#44,#88,#44,#22	; 060  <
                    defb #00,#EE,#00,#EE,#00,#00	; 061  =
                    defb #00,#88,#44,#22,#44,#88	; 062  >
                    defb #44,#AA,#22,#44,#00,#44	; 063  ?
                    defb #66,#BB,#DD,#FF,#CC,#66	; 064  @
                    defb #66,#AA,#AA,#EE,#AA,#AA	; 065  A
                    defb #CC,#AA,#CC,#AA,#AA,#CC	; 066  B
                    defb #44,#AA,#88,#88,#AA,#44	; 067  C
                    defb #CC,#AA,#AA,#AA,#AA,#CC	; 068  D
                    defb #EE,#88,#CC,#88,#88,#EE	; 069  E
                    defb #EE,#88,#CC,#88,#88,#88	; 070  F
                    defb #66,#88,#88,#AA,#AA,#66	; 071  G
                    defb #AA,#AA,#EE,#AA,#AA,#AA	; 072  H
                    defb #EE,#44,#44,#44,#44,#EE	; 073  I
                    defb #66,#22,#22,#22,#AA,#44	; 074  J
                    defb #AA,#AA,#CC,#AA,#AA,#AA	; 075  K
                    defb #88,#88,#88,#88,#88,#EE	; 076  L
                    defb #AA,#EE,#EE,#EE,#AA,#AA	; 077  M
                    defb #AA,#AA,#EE,#EE,#EE,#AA	; 078  N
                    defb #66,#AA,#AA,#AA,#AA,#CC	; 079  O
                    defb #CC,#AA,#AA,#CC,#88,#88	; 080  P
                    defb #44,#AA,#AA,#AA,#EE,#77	; 081  Q
                    defb #CC,#AA,#AA,#CC,#AA,#AA	; 082  R
                    defb #66,#88,#CC,#66,#22,#CC	; 083  S
                    defb #EE,#44,#44,#44,#44,#44	; 084  T
                    defb #AA,#AA,#AA,#AA,#AA,#66	; 085  U
                    defb #AA,#AA,#AA,#AA,#AA,#44	; 086  V
                    defb #AA,#AA,#EE,#EE,#EE,#44	; 087  W
                    defb #AA,#AA,#44,#AA,#AA,#AA	; 088  X
                    defb #AA,#AA,#AA,#44,#44,#44	; 089  Y
                    defb #EE,#22,#44,#44,#88,#EE	; 090  Z
                    defb #66,#44,#44,#44,#44,#66	; 091  [
                    defb #88,#88,#44,#44,#22,#22	; 092  \
                    defb #66,#22,#22,#22,#22,#66	; 093  ]
                    defb #44,#AA,#00,#00,#00,#00	; 094  ^
                    defb #00,#00,#00,#00,#00,#EE	; 095  _
                    defb #55,#AA,#00,#00,#00,#00	; 096  ~
                    defb #44,#EE,#44,#44,#44,#44	; 097  cross
                    defb #44,#EE,#44,#44,#EE,#44	; 098  double cross
                    defb #66,#88,#EE,#EE,#88,#66	; 099  euro
                    defb #66,#BB,#DD,#DD,#BB,#66	; 100  copyright
                    defb #EE,#22,#00,#00,#00,#00	; 101  -|
                    defb #44,#AA,#44,#00,#00,#00	; 102  gradus
                    defb #44,#EE,#44,#00,#EE,#00	; 103  +-
                    defb #44,#44,#44,#44,#44,#44	; 104  |
                    defb #00,#00,#FF,#00,#00,#00	; 105  pseudographic -
                    defb #44,#44,#FF,#44,#44,#44	; 106  pseudographic cross
                    defb #00,#00,#CC,#44,#44,#44	; 107  pseudographic left-down
                    defb #00,#00,#77,#44,#44,#44	; 108  pseudographic right-down
                    defb #44,#44,#CC,#00,#00,#00	; 109  pseudographic left-up
                    defb #44,#44,#77,#00,#00,#00	; 110  pseudographic right-up
                    defb #22,#EE,#44,#EE,#88,#00	; 111  <>
                    defb #22,#55,#44,#EE,#44,#FF	; 112  funt
                    defb #22,#44,#CC,#44,#44,#22	; 113  {
                    defb #88,#44,#66,#44,#44,#88	; 114  }
                    defb #66,#AA,#AA,#EE,#AA,#AA	; 115  А
                    defb #EE,#88,#CC,#AA,#AA,#CC	; 116  Б
                    defb #CC,#AA,#CC,#AA,#AA,#CC	; 117  В
                    defb #EE,#88,#88,#88,#88,#88	; 118  Г
                    defb #22,#66,#AA,#AA,#AA,#FF	; 119  Д
                    defb #EE,#88,#CC,#88,#88,#EE	; 120  Е
                    defb #AA,#EE,#44,#EE,#EE,#AA	; 121  Ж
                    defb #CC,#22,#44,#22,#22,#CC	; 122  З
                    defb #AA,#AA,#AA,#EE,#EE,#AA	; 123  И
                    defb #44,#AA,#AA,#EE,#EE,#AA	; 124  Й
                    defb #AA,#AA,#CC,#AA,#AA,#AA	; 125  К
                    defb #22,#66,#AA,#AA,#AA,#AA	; 126  Л
                    defb #AA,#EE,#EE,#EE,#AA,#AA	; 127  М
                    defb #AA,#AA,#EE,#AA,#AA,#AA	; 128  Н
                    defb #66,#AA,#AA,#AA,#AA,#CC	; 129  О
                    defb #EE,#AA,#AA,#AA,#AA,#AA	; 130  П
                    defb #CC,#AA,#AA,#CC,#88,#88	; 131  Р
                    defb #44,#AA,#88,#88,#AA,#44	; 132  С
                    defb #EE,#44,#44,#44,#44,#44	; 133  Т
                    defb #AA,#AA,#AA,#66,#22,#CC	; 134  У
                    defb #44,#EE,#EE,#EE,#44,#44	; 135  Ф
                    defb #AA,#AA,#44,#AA,#AA,#AA	; 136  Х
                    defb #AA,#AA,#AA,#AA,#AA,#FF	; 137  Ц
                    defb #AA,#AA,#AA,#66,#22,#22	; 138  Ч
                    defb #AA,#AA,#EE,#EE,#EE,#EE	; 139  Ш
                    defb #AA,#AA,#EE,#EE,#EE,#FF	; 140  Щ
                    defb #CC,#44,#66,#55,#55,#66	; 141  Ъ
                    defb #99,#99,#DD,#BB,#BB,#DD	; 142  Ы
                    defb #88,#88,#CC,#AA,#AA,#CC	; 143  Ь
                    defb #CC,#22,#66,#22,#22,#CC	; 144  Э
                    defb #AA,#DD,#DD,#DD,#DD,#AA	; 145  Ю
                    defb #66,#AA,#AA,#66,#AA,#AA	; 146  Я


; таблица адресов для пиксельных строк экрана

table_addr_scr		defw	#4000,#4100,#4200,#4300,#4400,#4500,#4600,#4700
			defw	#4020,#4120,#4220,#4320,#4420,#4520,#4620,#4720
			defw	#4040,#4140,#4240,#4340,#4440,#4540,#4640,#4740
			defw	#4060,#4160,#4260,#4360,#4460,#4560,#4660,#4760
			defw	#4080,#4180,#4280,#4380,#4480,#4580,#4680,#4780
			defw	#40a0,#41a0,#42a0,#43a0,#44a0,#45a0,#46a0,#47a0
			defw	#40c0,#41c0,#42c0,#43c0,#44c0,#45c0,#46c0,#47c0
			defw	#40e0,#41e0,#42e0,#43e0,#44e0,#45e0,#46e0,#47e0

			defw	#4800,#4900,#4a00,#4b00,#4c00,#4d00,#4e00,#4f00
			defw	#4820,#4920,#4a20,#4b20,#4c20,#4d20,#4e20,#4f20
			defw	#4840,#4940,#4a40,#4b40,#4c40,#4d40,#4e40,#4f40
			defw	#4860,#4960,#4a60,#4b60,#4c60,#4d60,#4e60,#4f60
			defw	#4880,#4980,#4a80,#4b80,#4c80,#4d80,#4e80,#4f80
			defw	#48a0,#49a0,#4aa0,#4ba0,#4ca0,#4da0,#4ea0,#4fa0
			defw	#48c0,#49c0,#4ac0,#4bc0,#4cc0,#4dc0,#4ec0,#4fc0
			defw	#48e0,#49e0,#4ae0,#4be0,#4ce0,#4de0,#4ee0,#4fe0

			defw	#5000,#5100,#5200,#5300,#5400,#5500,#5600,#5700
			defw	#5020,#5120,#5220,#5320,#5420,#5520,#5620,#5720
			defw	#5040,#5140,#5240,#5340,#5440,#5540,#5640,#5740
			defw	#5060,#5160,#5260,#5360,#5460,#5560,#5660,#5760
			defw	#5080,#5180,#5280,#5380,#5480,#5580,#5680,#5780
			defw	#50a0,#51a0,#52a0,#53a0,#54a0,#55a0,#56a0,#57a0
			defw	#50c0,#51c0,#52c0,#53c0,#54c0,#55c0,#56c0,#57c0
			defw	#50e0,#51e0,#52e0,#53e0,#54e0,#55e0,#56e0,#57e0


string_temp	defb	0					; промежуточная переменная-строка (первый байт - длина строки, 255 байт - коды символов строки)
				dup	255
				defb	32
				edup

col_screen			defb	0					; столбец экрана
row_screen			defb	0					; строка экрана
half_tile_screen		defb	0			; полузнакоместо (0=первое/1=второе)
attr_screen			defb	56				; атрибуты экрана

col_screen_temp			defw	0					; временные координаты на экране
half_tile_screen_temp		defb	0					; временное полузнакоместо

*/

;+-------------------------------------------------------------+
;| Ultra-Fast печаталка на 64 символа: Eraser/Delirium Tremens |
;+-------------------------------------------------------------+
;|¬ход:  HL    - адрес печати на экране                        |
;|       DE    - адрес расположени€ данных дл€ печати (64 byte)|
;|¬ыход: HL    - адрес след. строчки в сигменте                |
;+-------------------------------------------------------------+
  ORG #8000
prg_start: JP Start
FONT64 equ #C000
FONT64h equ #C0
ORG #C000
  incbin "3_cp866.bin"

Start   LD HL,#4000
        LD DE,SPACE
        CALL PRT_64
        RET

SPACE   DEFB "Welcome to RusNet Cyberspace. Пристегните ремни..."

PRT_64  LD B,#40/#02
Loop_64 PUSH BC
        LD A,(DE)
        CALL PR_64_L
        INC DE
        LD A,(DE)
        CALL PR_64_R
        INC DE
        POP BC
        DJNZ Loop_64
        RET

PR_64_L LD B,FONT64h; ѕечать в левой части знакоместа
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

PR_64_R LD B,FONT64h; ѕечать в правой части знакоместа
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

SAVESNA "myzx.sna",prg_start
