script_begin:
	rInitTiles TILE_SET
	rInitMap MAP_SET
	rInitChars CHARS_SET
	;rExec Map.init_map
	rShowMapAt #0000
script_loop:
	;PRINT_AT 10,10, MY_HELLO
	;rShowMapAt #0000
	;rRandomScreen
	;rCALL showScreen
	;rCALL showMap
	rScanKeys scanTable
	;rExec Entities.charLoops
	;FPS_CALC
	;WAIT 1
	;WAIT_ANY_KEY
	GOTO script_loop
	defb _endByte

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
  rShowMapAt #0000
  defb _endByte

keyLeft:
  rExec Map.scr_left
  rShowMapAt #0000
  defb _endByte

keyDown:
  rExec Map.scr_down
  rShowMapAt #0000
  defb _endByte

keyUp:
  rExec Map.scr_up
  rShowMapAt #0000
  defb _endByte
