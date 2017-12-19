  MODULE rpglang

  MACRO rpglang.saveScriptAddr
    LD (rpglang.process+1), HL
  ENDM

  MACRO rpglang.start ptr
    LD HL, ptr
    rpglang.saveScriptAddr
    jp rpglang.process
  ENDM

; на входе в DE - адрес скриптов
/*call_script:
  PUSH HL
  POP HL
  jr rpglang.process*/

; на входе в HL - адрес скриптов
process:
  LD HL, 0x0000
process_lp:
  LD a, (HL)
  ;cp _endByte
  AND A; _endByte -> end
	ret z
  INC HL
  dec a; script system
  jp z, script_system.enter
  dec a; graphic system
  jp z, graphic_system.enter
  dec a; input system
  jr z, input_system.enter
  dec a; sound system
  jp z, sound_system.enter
  dec a; gfx system
  jp z, gfx_system.enter
  dec a; gfx system
  JP z, rpg_system.enter
  ; иначе непонятный оператор - выходим!
  ret
  ;jr process_lp

ENDMODULE
