  MODULE personages

STRUCT pers
y db 0; pos y
x db 0; pos x
action db 0; action
action_max db 0; action max
hp db 0;hit point
hp_max db 0;hit point max
strength db 0;strength
prot db 0;protection
sprite: db 0;sprite view of personage
floor: db 0;floor sprite
name_p dw 0;pointer to name
ENDS

STRUCT item
name_p dw 0; pointer to name
charge db 0; charge of nums of bullet in cell
ENDS

init
  LD B, PersonagesNum
  LD HL, persArray
init_loop; пробегаемся по всем персонажам и размещаем их на карте
  LD DE, pers
  PUSH BC
  PUSH DE
  PUSH HL
  call init_personage
  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ init_loop
  RET

; инициализация и размещение персонажа на карте
; в HL - указатель на персонажа
init_personage;
  LD IX,HL
  LD D, (IX+pers.y); pos y
  LD E, (IX+pers.x); pos x
  call map.pos_to_addr
  LD A, (HL)
  LD (IX+pers.floor),A; ячейку карты ставим на пол персонажа
  LD A, (IX+pers.sprite)
  LD (HL), A ; ставим спрайт персонажа на карту
  RET

persArray include persFile

  ENDMODULE