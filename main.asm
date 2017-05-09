;include "example_text64/main.asm"
;include "magenuar/main.asm"
;include "murkn/main.asm"
;include "game_toglory/main.asm"
;include "game_rusnet/main.asm"
;include "game_combi/main.asm"
;LABELSLIST "labels.lst"
;./xpeccy.app/Contents/MacOS/xpeccy -s myzx.sna -l labels.lst
;./Fuse.app/Contents/MacOS/Fuse -s myzx.sna


; myzx.sublime-build
;{
;	"cmd": ["./make.sh"],
;	"shell": "bash"
;}


DEVICE zxspectrum48
//org #7000;
//prg_start:

/*
MACRO	_wait	time
  db	0
  dw	time
ENDM

MACRO	_poke	addr, value
  db	1
  dw	addr
  db	value
ENDM

MACRO	_call	addr
  db	2
  dw	addr
ENDM

MACRO	_init	addr
  db	3
  dw	addr
ENDM

wait_frame
  halt
  ret


off 		equ 0
on		equ 1

  ei
loop call wait_frame
main_proc	call 0
  jp loop
  RET

int	push af
		push hl
		push de
		push bc
frames	ld hl,0
		inc hl
		ld (frames+1),hl
frames_wait	ld de,1
		or a
		sbc hl,de
		jp c,en_ex

en_proc		ld hl,proc_db
		ld a,(hl)
		cp #ff
		jr nz,en_proc0
		ld hl,0
		ld (frames+1),hl
		inc l
		ld (frames_wait+1),hl
		ld hl,proc_loop
		ld (en_proc+1),hl
		jr en_proc

en_proc0	or a		; _wait
		jr nz,en_proc1
		call en_pop
		ex de,hl
		ld (frames_wait+1),hl
		ex de,hl
		jr en_proc_ex

en_proc1	dec a		; _poke
		jr nz,en_proc2
		call en_pop
		ld a,(hl)
		ld (de),a
en_proc_cycle	inc hl
		ld (en_proc+1),hl
		jr en_proc

en_proc2	dec a		; _call
		jr nz,en_proc3
		call en_pop
		ex de,hl
		ld (main_proc+1),hl
		ex de,hl
		jr en_proc_ex

en_proc3	dec a		; _init
		jr nz,en_proc4
		call en_pop
		ld (en_proc+1),hl
		ex de,hl
		ld (main_proc+1),hl
		jr en_ex

en_proc4	inc hl
en_proc_ex	ld (en_proc+1),hl

en_ex        	pop bc
		pop de
		pop hl
		pop af
		ei
		ret

en_pop		inc hl
		ld e,(hl)
		inc hl
		ld d,(hl)
		inc hl
en_pop_ex	ret
*/

	ORG	#8000	;старт программы ровно по центру памяти 48К
prg_start:

	LD HL,snd_start
        CALL vt_start+3

	DI		;запрет прерываний на всякий случай

	XOR A
	OUT(#FE),A
	CALL RAND_INIT

	LD   HL,POPOV
       	LD   DE,#4000
       	LD   BC,#1B00
       	LDIR

dt equ 32*4

LOOP0
	DI
	CALL RND255
	LD (LOOP2+1), A
	AND %01111000
	OUT(#FE),A
	LD SP, #5B00-dt
	;LD C,192/4 ;в регистр C кладем ширину экрана в байтах
LOOP2
	LD A, 0x00
	AND %01111000
	LD D,A
	LD E,A

    	DUP 192*2-dt/2
    	PUSH DE
    	EDUP

	EI
	HALT
	CALL vt_start+5
	JP LOOP0

RAND_INIT
	LD HL, (23670)
	LD (RND255+1), HL
RND255 	LD    HL,0x0000
       	LD    DE,7        ;дальше следует расчет очередного
                         ; значения счетчика
       	ADD   HL,DE
       	LD    E,L
       	LD    D,H
       	ADD   HL,HL
       	ADD   HL,HL
       	LD    C,L
       	LD    B,H
       	ADD   HL,HL
       	ADD   HL,BC
       	ADD   HL,DE
       	LD    (RND255+1),HL   ;сохранение значения счетчика «случайных»
                         ; чисел для последующих расчетов
       	LD    A,H         ;регистр A загружается значением
                         ; старшего байта счетчика
	RET                         

prg_end
data_start

POPOV: 
	incbin "popov.scr"

snd_start:
	incbin "Jubbles_.pt3"

data_end

ORG #C000	
vt_start:
	include "PTSPLAY.ASM"
vt_end

display "prog: ", prg_start, " ", prg_end
display "data: ", data_start, " ", data_end
display "player: ", vt_start, " ", vt_end

display /D, $-prg_start, " size, ", /D, 0x10000-$, " free"

SAVESNA "myzx.sna",prg_start
