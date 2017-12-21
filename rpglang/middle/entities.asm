  MODULE Entities

act_end   EQU 0x00
act_stand EQU 0x01
act_look  EQU 0x02
act_take  EQU 0x03
act_use   EQU 0x04
;act_fire  EQU 0x05

; ячейка карты cell
; действия :
; stand  - встать на ячейку карты
; look   - осмотреть ячейку карты
; take   - взять ячейку карты
; use X  - применить предмет X
; over  - метнуть предмет X через предмет

activePersonage_ptr dw #0000; // указатель на текущего персонажа
RevertPersonageNum db #00; инверсный номер персонажа ( от PersonagesNum до 0!!!)

STRUCT CellType
prot db 00; проницаемость для предметов
force_destr db 00; сила для уничтожения
ENDS

STRUCT Cell
type_c db 00; супертип ячейки
sprite db 00; спрайт

ENDS

STRUCT Item
pos Point 0,0 ; позиция на карте
type_i db 00; тип предмета
sprite db 00; спрайт
ground db 00; на чем стоит
flags db 00; признаки-флаги
charge db 00; заряд
name_p dw #0000
ENDS

STRUCT Hero
pos Point 0,0 ; позиция на карте
sprite db 00; спрайт
ground db 00; на чем стоит
flags db 00; признаки-флаги
name_p dw #0000
ENDS

; перебираем по кругу персонажей от стартового до последнего и опять на первый
loopNextChar:
  CALL nextChar
  RET NZ
firstChar:
  LD DE, (persArray)
  ld (activePersonage_ptr), DE
  LD A, PersonagesNum
  LD (RevertPersonageNum), A
  RET

nextChar: ; если у нас признак Z в 1 значит достилги конца массива
  LD A, (RevertPersonageNum)
  DEC A
  RET Z; если у нас обнулился счетчик - возвращаемся
  LD (RevertPersonageNum), A
  LD DE, (activePersonage_ptr)
  LD HL, Hero
  ADD HL, DE
  LD (activePersonage_ptr), HL
  OR 2
  RET

lookChar:; смотрим на текущего персонажа
  LD IX, (activePersonage_ptr)
  LD DE, (IX+Hero.pos)
  CALL Map.center_at_map
  CALL Map.showMap
  RET

/*charLoops:
  call firstChar;
char_loop:
  call lookChar
  call nextChar
  JR NZ, char_loop
  RET*/

; в HL - указатель на массив персонажей
initChars:
  LD (persArray), HL
persArray_ptr:
  LD HL, #0000
PersonagesNum_ptr:
  LD B, PersonagesNum
  ;LD HL, persArray
init_loop; пробегаемся по всем персонажам и размещаем их на карте
  LD DE, Hero
  PUSH BC
  PUSH DE
  PUSH HL
  call init_personage
  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ init_loop
  CALL firstChar
  RET

; инициализация и размещение персонажа на карте
; в HL - указатель на персонажа
init_personage;
  LD IX,HL
  LD DE, (IX+Hero.pos)
  call Map.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  RET

; передвижение персонажа
; фактически - только изменение его координат в массиве!
; карту в этих процедурах вообще не трогаем
; указатель на текущего персонажа - IX
charUp
  LD IX, (activePersonage_ptr)
  LD A, (IX+Hero.pos.y)
  DEC A
  RET M
  LD (IX+Hero.pos.y),A
  RET

charLeft
  LD IX, (activePersonage_ptr)
  LD A, (IX+Hero.pos.x)
  DEC A
  RET M
  LD (IX+Hero.pos.x),A
  RET

charRight
  LD IX, (activePersonage_ptr)
  LD A, (IX+Hero.pos.x)
  INC A
  CP mapSize
  RET NC
  LD (IX+Hero.pos.x),A
  RET

charDown
  LD IX, (activePersonage_ptr)
  LD A, (IX+Hero.pos.y)
  INC A
  CP mapSize
  RET NC
  LD (IX+Hero.pos.y),A
  RET

persArray equ persArray_ptr+1 // указатель на массив карты
  ENDMODULE
