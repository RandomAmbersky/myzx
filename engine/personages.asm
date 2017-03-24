  MODULE Personages

STRUCT pers
pos Point 0,0
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

; получить указатель на данные персонажа в currPersonage
; по его номеру
; Вход: A - номер персонажа
; Выход: указатель на данные персонажа в currPersonage, в HL
getHero:
  LD HL, persArray
  CP 00
  JR Z, ret_hero
  LD DE, pers; длина записи о персонаже
  LD B, A; номер персонажа
loop_get_hero:
  ADD HL, DE
  DJNZ loop_get_hero
ret_hero:
  LD (currPersonage), HL
  RET

; в поиске персонажа
; Вход: DE - позиция на карте, D-x, E-y
; Выход - A=1, в currPersonage указатель на персонажа
;         A=0 если персонаж не найден
find_at:
  LD IX, persArray; указатель на массив персонажей
  LD B, PersonagesNum; число персонажей
 ;  проверяем совпадают ли координаты c персонажем
check_pers:
  LD A, (IX+pers.pos.y)
  CP E
  JR NZ, next_pers
  LD A, (IX+pers.pos.x)
  CP D
  JR NZ, next_pers
; нашли!
  LD (currPersonage), IX
  LD A, 1;
  RET
next_pers:
  PUSH BC
  LD BC, pers
  ADD IX, BC
  POP BC
  DJNZ check_pers
  XOR A
  RET; не нашли :(

; передвижение персонажа
; фактически - только изменение его координат в массиве!
; карту в этих процедурах вообще не трогаем
; указатель на текущего персонажа - IX
move_up
  LD A, (IX+pers.pos.y)
  DEC A
  RET M
  LD (IX+pers.pos.y),A
  RET

move_down
  LD A, (IX+pers.pos.x)
  DEC A
  RET M
  LD (IX+pers.pos.x),A
  RET

move_right
  LD A, (IX+pers.pos.x)
  INC A
  CP mapSize
  RET NC
  LD (IX+pers.pos.x),A
  RET

move_left
  LD A, (IX+pers.pos.x)
  INC A
  CP mapSize
  RET NC
  LD (IX+pers.pos.x),A
  RET

; а тут уже пихаем их в ячейки карты
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
  LD DE, (IX+pers.pos)
  call Map.pos_to_addr
  LD A, (HL)
  LD (IX+pers.floor),A; ячейку карты ставим на пол персонажа
  LD A, (IX+pers.sprite)
  LD (HL), A ; ставим спрайт персонажа на карту
  RET

persArray include persFile

  ENDMODULE
