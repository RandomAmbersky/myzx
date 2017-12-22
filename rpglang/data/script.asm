script_begin:
	rpg.InitTiles TILE_SET
	rpg.InitMap MAP_SET
	rpg.InitChars CHARS_SET
	;rExec Map.fill_map
	;rBorder PEN_BLACK
	;rShowMap
	rExec Entities.loopNextChar
	rExec Entities.lookChar
script_loop:
	rBorder PEN_BLACK
	;rExec Map.calc_pos
	;rExec Map.showMap
	;PRINT_AT 10,10, MY_HELLO
	;rBorder PEN_BLUE
	;rExec Map.look_at_map
	;rBorder PEN_RED
	;rExec Map.showMap
	;rRandomScreen
	;rBorder PEN_YELLOW
	;rCALL showScreen
	;rCALL showMap
	;rScanKeys scanTable
	;rBorder PEN_CYAN
	;rExec border_blue
	;rScanKeys scanTable
	;rExec Entities.charLoops
	;FPS_CALC
	;rBorder PEN_RED
	rScanKeys scanMainLoopTable
	;rExec Entities.loopNextChar
	;rBorder PEN_WHITE
	;rExec Entities.lookChar
	;WAIT 1
	;WAIT_ANY_KEY
	;rCALL startLoop
	;rBorder PEN_BLACK
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
;script_loop2:
	;rScanKeys scanCharKeysTable
	GOTO script_loop
	defb _endByte

scanMainLoopTable:
	KEY_N, keyNextChar
	;KEY_0, keyEndTurn
	KEY_Q, keyCharUp
	KEY_A, keyCharDown
	KEY_O, keyCharLeft
	KEY_P, keyCharRight
	defb _endByte

keyNextChar:
	rExec Entities.loopNextChar
	rExec Entities.lookChar
	defb _endByte

keyEndTurn:
	rBorder PEN_RED
	defb _endByte

/* startLoop: // выбран и может ходить
	;rpg.NextChar
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
;startLoop2:
	;rBorder PEN_RED
	;rScanKeys scanCharKeysTable
	rBorder PEN_YELLOW
	;GOTO startLoop
	defb _endByte */

/* scanCharKeysTable:
	KEY_P, keyCharEnd
	;KEY_Q, keyCharUp
  ;KEY_A, keyCharDown
  ;KEY_O, keyCharLeft
  ;KEY_P, keyCharRight
	defb _endByte */

/* keyCharEnd:
	;rpg.NextChar
	rBorder PEN_RED
	;rExec Entities.loopNextChar
	;rExec Entities.lookChar
	defb _endByte */

keyCharUp:
	;rBorder PEN_RED
	;rPlayFX 1
	rExec Entities.charUp
	rExec Entities.lookChar
	defb _endByte

keyCharDown:
	;rBorder PEN_CYAN
	;rPlayTweet 1
	rExec Entities.charDown
	rExec Entities.lookChar
	defb _endByte

keyCharLeft:
	;rBorder PEN_YELLOW
	;rPlayVibr 1
	rExec Entities.charLeft
	rExec Entities.lookChar
	defb _endByte

keyCharRight:
	;rBorder PEN_GREEN
	;rPlayLaser 1
	rExec Entities.charRight
	rExec Entities.lookChar
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
