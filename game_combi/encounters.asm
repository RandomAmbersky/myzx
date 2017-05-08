  MODULE encounters

act_end   EQU 0x00
act_stand EQU 0x01
act_look  EQU 0x02
act_take  EQU 0x03
act_use   EQU 0x04

  MACRO set_action action,action_ptr
    defb action
    defw action_ptr
  ENDM

; ячейка карты cell
; действия :
; stand  - встать на ячейку карты
; look   - осмотреть ячейку карты
; take   - взять ячейку карты
; use X  - применить предмет X

; Обработать действие на ячейке карты
; Вход: DE - ячейка карты,  D - x, E - y
; B - направление движения
; C - действие
process_cell_action:
  PUSH BC
  call map.get_cell; на выходе в HL - указатель на ячейку, A - содержимое ячейки
  LD L,A
  LD H,0
  ADD HL, HL; массив у нас dw - умножаем на два..
  LD BC, cells_types_spr
  ADD HL, BC
  LD DE,(HL); в DE адрес процедуры обработки действия
  POP BC; b - направление движения, c - action
process_cell_loop:
  LD A,(DE)
  CP 0
  RET Z
  CP C
  JR Z, process_action_find
  INC DE
  INC DE
  INC DE; у нас db и dw - +3
  JR process_cell_loop
process_action_find:
  INC DE
  LD ( process_action_jp+1), DE
process_action_jp:
  JP 0000

; массив соответствия кода спрайта на карте типу энкаунтера
cells_types_spr:
  dw cGround, cWater, cGreenBush

cGround:
  set_action act_stand, move_on_cell
  db act_end

cWater:
  db act_end

cGreenBush:
  db act_end

move_on_cell:
  RET

; предметы item
; look
; take
; use X

; персонажи hero

  ENDMODULE
