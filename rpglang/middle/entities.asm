  MODULE Entities

act_end   EQU 0x00
act_stand EQU 0x01
act_look  EQU 0x02
act_take  EQU 0x03
act_use   EQU 0x04
act_fire  EQU 0x05

; ячейка карты cell
; действия :
; stand  - встать на ячейку карты
; look   - осмотреть ячейку карты
; take   - взять ячейку карты
; use X  - применить предмет X
; over  - метнуть предмет X через предмет

activePersonage_ptr dw #0000; // указатель на текущего персонажа
RevertPersonageNum db #00; инверсный номер персонажа ( от PersonagesNum до 0!!!)

STRUCT Hero
pos Point 0,0 ; позиция на карте
sprite db 00; спрайт
ground db 00; на чем стоит
flags db 00; признаки-флаги
name_p dw #0000
ENDS

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

lookChar; смотрим на текущего персонажа
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

persArray equ persArray_ptr+1 // указатель на массив карты
  ENDMODULE
