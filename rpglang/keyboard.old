;------------------------------------------------------------------------------
; This file is part of the ZX Spectrum libzx library by Sebastian Mihai, 2016
;------------------------------------------------------------------------------

;------------------------------------------------------------------------------
;
; Keyboard routines
;
; The high amount of code duplication in this file is for the sake of speed.
;
;------------------------------------------------------------------------------

KEY_B equ %00010000
KEY_H equ %00010000
KEY_Y equ %00010000
KEY_6 equ %00010000
KEY_5 equ %00010000
KEY_T equ %00010000
KEY_G equ %00010000
KEY_V equ %00010000

KEY_N equ %00001000
KEY_J equ %00001000
KEY_U equ %00001000
KEY_7 equ %00001000
KEY_4 equ %00001000
KEY_R equ %00001000
KEY_F equ %00001000
KEY_C equ %00001000

KEY_M equ %00000100
KEY_K equ %00000100
KEY_I equ %00000100
KEY_8 equ %00000100
KEY_3 equ %00000100
KEY_E equ %00000100
KEY_D equ %00000100
KEY_X equ %00000100

KEY_SYMBOL_SHIFT equ %00000010
KEY_L equ %00000010
KEY_O equ %00000010
KEY_9 equ %00000010
KEY_2 equ %00000010
KEY_W equ %00000010
KEY_S equ %00000010
KEY_Z equ %00000010

KEY_SPACE equ %00000001
KEY_ENTER equ %00000001
KEY_P equ %00000001
KEY_0 equ %00000001
KEY_1 equ %00000001
KEY_Q equ %00000001
KEY_A equ %00000001
KEY_CAPS_SHIFT equ %00000001

; How to read the keyboard:
;
; Step 1 - select key row in the accumulator by loading port number to the left
;
; $7F - B, N, M, Symbol Shift, Space
; $BF - H, J, K, L, Enter
; $DF - Y, U, I, O, P
; $EF - 6, 7, 8, 9, 0
; $F7 - 5, 4, 3, 2, 1
; $FB - T, R, E, W, Q
; $FD - G, F, D, S, A
; $FE - V, C, X, Z, Caps Shift
;
;       4  3  2  1  0        These bits will be 0 if the corresponding
;                            key is pressed
; Step 2 - in a, ($FE)
; Step 3 - look for bit values of 0 to find pressed keys, as shown above

read_any_key:

  ld a, #7F
  in a, (#FE)
  ret

  ld b, a

  ld a, $BF
  in a, ($FE)
  and b
  ld b, a

  ld a, $DF
  in a, ($FE)
  and b
  ld b, a

  ld a, $EF
  in a, ($FE)
  and b
  ld b, a

  ld a, $F7
  in a, ($FE)
  and b
  ld b, a

  ld a, $FB
  in a, ($FE)
  and b
  ld b, a

  ld a, $FD
  in a, ($FE)
  and b
  ld b, a

  ld a, $FE
  in a, ($FE)
  and b
  ;ld b, a

  ret
