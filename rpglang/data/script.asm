script_begin:
	rInitTiles TILE_SET
	rInitMap MAP_SET
	rInitChars CHARS_SET
	;rExec Map.init_map
	;rShowMapAt #0000
script_loop:
	rBorder PEN_BLACK
	PRINT_AT 10,10, MY_HELLO
	rBorder PEN_BLUE
	;rExec border_red
	;rShowMapAt #0000
	rBorder PEN_RED
	rRandomScreen
	rBorder PEN_YELLOW
	;rCALL showScreen
	;rCALL showMap
	rScanKeys scanTable
	rBorder PEN_CYAN
	;rExec border_blue
	;rScanKeys scanTable
	;rExec Entities.charLoops
	FPS_CALC
	;rBorder PEN_RED
	;rExec border_red
	;rScanKeys scanTable
	;WAIT 1
	;WAIT_ANY_KEY
	GOTO script_loop
	defb _endByte

/*border_white:
	LD A,7
	OUT(#FE),A
	RET*/

/*border_blue:
	LD A,01
	OUT(#FE),A
	RET

border_red:
	LD A,02
	OUT(#FE),A
	RET*/

showScreen:
	rRandomScreen
	FPS_CALC
	defb _endByte

scanTable:
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
  ;rShowMapAt #0000
  defb _endByte

keyLeft:
  rExec Map.scr_left
  ;rShowMapAt #0000
  defb _endByte

keyDown:
  rExec Map.scr_down
  ;rShowMapAt #0000
  defb _endByte

keyUp:
  rExec Map.scr_up
  ;rShowMapAt #0000
  defb _endByte
