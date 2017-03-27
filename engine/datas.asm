  MODULE datablock

;ORG #9000
;tiles_start equ $
  DISPLAY "--- datablock begin: ",$
mapTiles include tileFile
  DISPLAY "tileFile end ",$
mapArray include mapFile
  DISPLAY "mapFile end ",$
;persArray include persFile

SCREEN_SEGMENT_SIZE EQU 2048
SCREEN_SEGMENT_LINES EQU 64
SCREEN_ATTRIBUTES_SIZE EQU 768
SCREEN_TOTAL_SIZE EQU 3*SCREEN_SEGMENT_SIZE + SCREEN_ATTRIBUTES_SIZE
    DISPLAY "--- datablock end: ",$

ORG #C000
DISPLAY "--- shadowscreen begin: ",$
SHADOW_SCREEN_ADDR:
 DS SCREEN_TOTAL_SIZE-SCREEN_ATTRIBUTES_SIZE
SHADOW_ATTR_ADDR:
 DS SCREEN_ATTRIBUTES_SIZE, %00111000
 DISPLAY "--- shadowscreen end: ",$

 ORG  #E000
 DISPLAY "--- interrupt begin: ",$
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
 ;call 49158          ; play music.
 ;rst 56              ; ROM routine, read keys and update clock.
 ;ld a, (frame_counter)
 ;INC A
 ;CP 50
 ;JR NC, return_routine:
 ;ld hl, SCREEN_ADDR
 ;ld de, #4000
 ;CALL shadowscreen.copy_to_buf
 ;XOR a
return_routine:
 ;inc a
 ;ld (frame_counter), a
 pop ix              ; restore registers.
 pop de
 pop hl
 pop bc
 pop af
 EI
 ret
 DISPLAY "--- interrupt end: ",$

  ENDMODULE
