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

STRUCT Hero
pos Point 0,0 ; позиция на карте
sprite db 00; спрайт
ground db 00; на чем стоит
name_p dw #0000
ENDS

; в HL - указатель на массив персонажей
initChars:
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
  RET

; инициализация и размещение персонажа на карте
; в HL - указатель на персонажа
; в A - номер его спрайта
init_personage;
  LD IX,HL
  LD DE, (IX+Hero.pos)
  call Map.look_at
  LD A,(HL)
  LD (IX+Hero.ground),A; ячейку карты ставим на пол персонажа
  LD A,(IX+Hero.sprite)
  LD (HL),A ; ставим спрайт персонажа на карту
  RET

  ENDMODULE
