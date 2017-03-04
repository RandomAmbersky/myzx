  MODULE Personages

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

currPersonage dw 0; pointer to persArray

; в поиске персонажа
; Вход: DE - позиция на карте, D-y, E-x
; Выход - A=1, в currPersonage указатель на персонажа
;         A=0 если персонаж не найден
find_at
  LD IX, (persArray); указатель на массив персонажей
  LD B, PersonagesNum; число персонажей
 ;  проверяем совпадают ли координаты c персонажем
check_pers:
  LD A, (IX+pers.y)
  CP D
  JR NZ, next_pers
  LD A, (IX+pers.x)
  CP E
  JR NZ, next_pers
; нашли!
  LD (currPersonage), IX
  LD A,1
  RET
next_pers:
  ADD IX, BC
  DJNZ check_pers
  XOR A
  RET; не нашли :(


; передвижение персонажа
; указатель на текущего персонажа - IX
move_up
  LD A, (IX+pers.y)
  DEC A
  RET M
  LD (IX+pers.y),A
  RET

move_down
  LD A, (IX+pers.x)
  DEC A
  RET M
  LD (IX+pers.x),A
  RET

move_right
  LD A, (IX+pers.x)
  INC A
  CP mapSize
  RET NC
  LD (IX+pers.x),A
  RET

move_left
  LD A, (IX+pers.x)
  INC A
  CP mapSize
  RET NC
  LD (IX+pers.x),A
  RET

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
  call Map.pos_to_addr
  LD A, (HL)
  LD (IX+pers.floor),A; ячейку карты ставим на пол персонажа
  LD A, (IX+pers.sprite)
  LD (HL), A ; ставим спрайт персонажа на карту
  RET

persArray include persFile

  ENDMODULE
