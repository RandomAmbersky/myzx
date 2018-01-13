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

MapCell_xy dw #0000;  // координаты на карте на которую воздействует персонаж ( заполняется в процедуре charCheckAction )
MapCell_ptr dw #0000;  // указатель на ячейку карты на которую воздействует персонаж ( заполняется в процедуре charCheckAction )

; тип ячейки на карте
STRUCT CellType
name_ptr dw 00; указатель на имя типа
script_ptr dw 00; указатель на скрипт обработки действий если нужен, иначе 0000
;--- разные части
;prot db 00; проницаемость для предметов, 00 - полностью проницаем
;force_destr db 00; сила для уничтожения
ENDS

STRUCT Cell
type_ptr dw 00; указатель на тип ячейки
sprite db 00; текущий спрайт
flags db 00; первые 7 флагов
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

; на входе в A - индекс типа ячейки
; на выходе - указатель на массив с ячейкой
  MACRO Entities.calcCellType:
  LD DE, CellType
  CALL math.mul_ADE
  LD DE, CELL_TYPES
  ADD HL, DE
  ENDM

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

; TODO сделать признак что на ячейке есть персонаж
; на входе HL - координаты курсора
charLookAtCell:
  PUSH HL; запоминаем
  CALL ScreenBuf.clean_info_screen
  POP HL
  PUSH DE; запомнили адрес экрана который очистили
  LD DE, (Map.mapPos)
  ADD HL, DE; получаем позицию pos куда смотрит курсор
  EX DE, HL
  CALL Map.calc_pos; в HL указатель на ячейку
  LD A, (HL); вот оно!!!! получили ячейку из карты =)
  Entities.calcCellType
  LD IY, HL
  LD HL, (IY+CellType.name_ptr)
  POP DE
  INC E; ( отступ в одно знакоместо ))
  LD A, #20
  ADD A,E
  LD E, A
  ;INC D
  CALL Text68.print_68at
  ;Text68.print68at 1,22, HL
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
init_loop; пробегаемся по всем персонажам и размещаем их на карте
  LD DE, Hero
  PUSH BC
  PUSH DE
  PUSH HL
  LD IX,HL

  LD DE, (IX+Hero.pos)
  call Map.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  POP HL
  POP DE
  POP BC
  ADD HL, DE
  DJNZ init_loop
  CALL firstChar
  RET

/* ; инициализация и размещение персонажа на карте
; в IX - указатель на персонажа
ground_to_pers_floor;
  LD DE, (IX+Hero.pos)
  call Map.calc_pos
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  RET */

/* ; возвращаем "пол" на котором стоял персонаж обратно на карту
; IX - указатель на текущего персонажа
pesr_floor_to_ground:
  LD DE, (IX+Hero.pos)
  call Map.calc_pos
  LD A,(IX+Hero.ground)
  LD (HL),A
  RET */

; двигаем персонажа вверх
charMoveUp
  LD B, act_stand; встаем на ячейку
  LD A, dir_up
  CALL charCheckAction
  RET C; нельзя двигаться никак
char_to_map_moved: ; двигаем персонажа на позицию MapCell_xy ( MapCell_ptr )
  ;CALL pesr_floor_to_ground; вместо этого - процедура ниже
  LD IX, (activePersonage_ptr);
  LD DE, (IX+Hero.pos) ;
  CALL Map.calc_pos    ; определяем координаты позиции персонажа в HL
  LD A,(IX+Hero.ground);
  LD (HL),A            ; и ставим на карту спрайт пола
  LD DE, ( MapCell_xy )
  LD (IX+Hero.pos), DE
  ;call ground_to_pers_floor; вместо этого - процедура ниже
  LD HL,( MapCell_ptr )
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  RET

; двигаем персонажа вниз
charMoveDown
  LD B, act_stand; встаем на ячейку
  LD A, dir_down
  CALL charCheckAction
  RET C; нельзя двигаться никак
  JR char_to_map_moved;

;двигаем персонажа влево
charMoveLeft
  LD B, act_stand; встаем на ячейку
  LD A, dir_left
  CALL charCheckAction
  RET C; нельзя двигаться никак
  JR char_to_map_moved;

charMoveRight
  LD B, act_stand; встаем на ячейку
  LD A, dir_right
  CALL charCheckAction
  RET C; нельзя двигаться никак
  JR char_to_map_moved;

; проверяем может ли текущий персонаж встать на ячейку
; если установлен флаг переноса SCF то не может
; в B - действие
; в A - направление
charCheckAction
  LD IX, (activePersonage_ptr)
  LD DE, (IX+Hero.pos);  D - x, E - y
  OR A
  JR Z, check_up
  DEC A
  JR Z, check_down
  DEC A
  JR Z, check_left
  DEC A
  JR Z, check_right
  JR charCheck_no; фигня какая-то
check_up:
  LD A,E
  DEC A
  JP M, charCheck_no
  LD E,A
  JR check_action
check_down:
  LD A,E
  INC A
  CP mapSize
  JP NC, charCheck_no
  LD E,A
  JR check_action
check_left:
  LD A,D
  DEC A
  JP M, charCheck_no
  LD D,A
  JR check_action
check_right:
  LD A,D
  INC A
  CP mapSize
  JR NC, charCheck_no
  LD D,A
check_action:; в DE у нас координаты ячейки на которую воздействует персонаж
  LD ( MapCell_xy ), DE
  call Map.calc_pos ; получаем указатель на ячейку карты в HL
  LD ( MapCell_ptr), HL
  LD A, (HL);  и берем оттуда индекс !
  DEC A; забавы ))
  JR Z, charCheck_no
charCheck_yes
  SCF ; устанавливаем бит переноса и инвертируем его ))
  CCF
  RET
charCheck_no
  SCF
  RET

persArray equ persArray_ptr+1 // указатель на массив карты
  ENDMODULE
