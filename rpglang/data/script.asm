; все согласно redux и Еntity-Component-Systems бугога!
; конечный автомат конечно же это )

; game mode
gm_var equ 10; системная переменная номер 10
gm_CHAR_MOVE equ 1; режим передвижения
gm_CURSOR_MOVE equ 2; режим курсора

	GOTO script_begin

script_pre_init_asm:
	LD DE, TILE_SET
	LD (Tiles16.sprArray), DE
	LD DE, MAP_SET
	LD (Map.mapArray), DE
	LD HL, CHARS_SET
	CALL Entities.initChars
	CALL Entities.loopNextChar
;l1_
	;CALL Entities.loopNextChar
	;LD DE, #0505
	;PUSH HL
	;CALL Map.calc_pos
	;PUSH BC
	;LD A,C
	;LD C,A
	;POP BC
	;LD C,A
	;NOP
	;POP HL
	CALL ScreenBuf.clean_all_screen

	;LD HL, MAP_SET
	;CALL Tiles16.show_tile_map;
	;loopNextChar
	;CALL Entities.lookChar
	;LD DE, #0505
	;CALL math.pos_scr; в DE - адрес на экране
	;LD C,A
	;LD HL, GUI_SET
	;CALL Tiles16.show_tile_on_map;HL - указатель на спрайт ;DE - экранный адрес */
;l1_
	;CALL input_system.cursor_scr_center
	;JP l1_
	;CALL Entities.lookChar
	;LD DE, #0000
	;CALL Map.look_at_map
	;LD HL, MAP_SET; показываем с 0x0
	;CALL Tiles16.show_tile_map; одно и то же что CALL Map.showMap
	;LD HL, TILE_SET
	;LD DE, SCREEN_ADDR
	;CALL Tiles16.show_tile_on_map
	RET;

script_begin:
	;CURSOR_SCR_INIT
	;rExec Map.look_at_map
	;rExec input_system.cursor_scr_center
	;rExec Entities.loopNextChar
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
	;GOTO script_begin
	;rpg.InitTiles TILE_SET
	;rpg.InitMap MAP_SET
	;rpg.InitChars CHARS_SET
	rBorder PEN_BLACK
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
	;rExec Map.look_at_map
	;WAIT_ANY_KEY
	;defb _endByte
	rSetVar gm_var, gm_CHAR_MOVE
	;CURSOR_SCR_INIT
; основной скрипт state-machine ;)
script_loop:
	rIfVar gm_var, gm_CHAR_MOVE, charMode
	rIfVar gm_var, gm_CURSOR_MOVE, cursorMode
	GOTO script_loop
	defb _endByte

proc_setCursorMode:
	WAIT_NO_KEY; ждем пока отпустит
	CURSOR_SCR_INIT
	rSetVar gm_var, gm_CURSOR_MOVE
	defb _endByte

proc_setCharMode:
	WAIT_NO_KEY; ждем пока отпустит
	rSetVar gm_var, gm_CHAR_MOVE
	defb _endByte

charMode:
	;rBorder PEN_BLACK
	rExec Entities.lookChar
	rScanKeys charScanKeysTable
	GOTO script_loop

cursorMode:
	;rBorder PEN_YELLOW
	rScanKeys cursorScanKeysTable
	GOTO script_loop

charScanKeysTable:
	;KEY_N, keyNextChar
	KEY_Q, keyCharUp
	KEY_A, keyCharDown
	KEY_O, keyCharLeft
	KEY_P, keyCharRight
	KEY_SPACE, proc_setCursorMode
	defb _endByte

;keyNextChar:
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
	;defb _endByte

;keyEndTurn:
;	rBorder PEN_RED
;	defb _endByte

;keyCursorReturn:
	;rBorder PEN_BLACK
	;defb _endByte

cursorScanKeysTable:
	KEY_Q, keyCursorUp
	KEY_A, keyCursorDown
	KEY_O, keyCursorLeft
	KEY_P, keyCursorRight
	KEY_SPACE, proc_setCharMode
	defb _endByte

proc_show_info
	;PRINT_AT 22,0, MY_HELLO
	CURSOR_SHOW_INFO
	defb _endByte

keyCursorUp
	;rBorder PEN_WHITE
	CURSOR_SCR_MOVE dir_up
	WAIT 5
	GOTO proc_show_info

keyCursorDown
	;rBorder PEN_RED
	CURSOR_SCR_MOVE dir_down
	WAIT 5
	GOTO proc_show_info

keyCursorLeft
	;rBorder PEN_BLUE
	CURSOR_SCR_MOVE dir_left
	WAIT 5
	GOTO proc_show_info

keyCursorRight
	;rBorder PEN_CYAN
	CURSOR_SCR_MOVE dir_right
	WAIT 5
	GOTO proc_show_info

/* keyCharEnd:
	;rpg.NextChar
	rBorder PEN_RED
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
	defb _endByte */

keyCharUp:
	;rBorder PEN_RED
	;rPlayFX 1
	rExec Entities.charMoveUp
	;rExec Entities.charUp
	;rExec Entities.lookChar
	defb _endByte

keyCharDown:
	;rBorder PEN_CYAN
	;rPlayTweet 1
	rExec Entities.charMoveDown
	;rExec Entities.lookChar
	defb _endByte

keyCharLeft:
	;rBorder PEN_YELLOW
	;rPlayVibr 1
	;rExec Entities.charLeft
	rExec Entities.charMoveLeft
	;rExec Entities.lookChar
	defb _endByte

keyCharRight:
	;rBorder PEN_GREEN
	;rPlayLaser 1
	;rExec Entities.charRight
	rExec Entities.charMoveRight
	;rExec Entities.lookChar
	defb _endByte

/*
scanTableTest:
  KEY_Q, keyUp
  KEY_A, keyDown
  KEY_O, keyLeft
  KEY_P, keyRight
	KEY_Z, keyLook
  defb _endByte

keyLook:
	rExec Entities.lookChar
	defb _endByte

keyRight:
  rExec Map.scr_right
  rShowMap
  defb _endByte

keyLeft:
  rExec Map.scr_left
  rShowMap
  defb _endByte

keyDown:
  rExec Map.scr_down
  rShowMap
  defb _endByte

keyUp:
  rExec Map.scr_up
  rShowMap
  defb _endByte
*/
