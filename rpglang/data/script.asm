; все согласно redux и Еntity-Component-Systems бугога!
; конечный автомат конечно же это )

; game mode
gm_var equ 0; системная переменная номер 0
gm_CHAR_MOVE equ 1; режим передвижения
gm_CURSOR_MOVE equ 2; режим курсора

script_begin:
	rpg.InitTiles TILE_SET
	rpg.InitMap MAP_SET
	rpg.InitChars CHARS_SET
	rBorder PEN_BLACK
	rExec Entities.loopNextChar
	rExec Entities.lookChar
	rSetVar gm_var, gm_CHAR_MOVE

; основной скрипт state-machine ;)
script_loop:
	rIfVar gm_var, gm_CHAR_MOVE, charMode
	rIfVar gm_var, gm_CURSOR_MOVE, cursorMode
	GOTO script_loop
	defb _endByte

proc_setCursorMode:
	WAIT_NO_KEY; ждем пока отпустит
	rSetVar gm_var, gm_CURSOR_MOVE
	defb _endByte

proc_setCharMode:
	WAIT_NO_KEY; ждем пока отпустит
	rSetVar gm_var, gm_CHAR_MOVE
	defb _endByte

charMode:
	rBorder PEN_RED
	rScanKeys charScanKeysTable
	rExec Entities.lookChar
	GOTO script_loop

cursorMode:
	rBorder PEN_YELLOW
	rScanKeys  cursorScanKeysTable
	GOTO script_loop

charScanKeysTable:
	;KEY_N, keyNextChar
	KEY_W, keyCharUp
	KEY_S, keyCharDown
	KEY_A, keyCharLeft
	KEY_D, keyCharRight
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
	KEY_W, keyCursorUp
	KEY_S, keyCursorDown
	KEY_A, keyCursorLeft
	KEY_D, keyCursorRight
	KEY_SPACE, proc_setCharMode
	defb _endByte

keyCursorUp
	rBorder PEN_WHITE
	CURSOR_SCR_MOVE dir_up
	WAIT 5
	defb _endByte

keyCursorDown
	rBorder PEN_RED
	CURSOR_SCR_MOVE dir_down
	WAIT 5
	defb _endByte

keyCursorLeft
	rBorder PEN_BLUE
	CURSOR_SCR_MOVE dir_left
	WAIT 5
	defb _endByte

keyCursorRight
	rBorder PEN_CYAN
	CURSOR_SCR_MOVE dir_right
	WAIT 5
	defb _endByte

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
