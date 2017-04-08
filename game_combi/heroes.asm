  MODULE heroes

  STRUCT add_base
pos Point 0,0
sprite db 0;map sprite
floor db 0;floor sprite
name_p dw 0;pointer to name
  ENDS

  STRUCT hero
base add_base
hp dw 1200
  ENDS

heroArray dw 00

  MACRO heroes.hero_def x,y, name_p, sprite, hp
heroes.hero x,y,0,name_p, sprite, hp
  ENDM

  MACRO heroes.set hero_p
    LD HL, hero_p
    LD (heroes.heroArray), HL
  ENDM

  ; а тут уже пихаем их в ячейки карты
init
    LD B, heroNum
    LD HL, (heroArray)
init_loop; пробегаемся по всем персонажам и размещаем их на карте
    LD DE, hero
    PUSH BC
    PUSH DE
    PUSH HL
    call init_heroes
    POP HL
    POP DE
    POP BC
    ADD HL, DE
    DJNZ init_loop
    RET

  ; инициализация и размещение персонажа на карте
  ; в HL - указатель на персонажа
init_heroes
    LD IX,HL
    LD DE, (IX+hero.base.pos)
    call map.pos_to_addr
    LD A, (HL)
    LD (IX+hero.base.floor),A; ячейку карты ставим на пол персонажа
    LD A, (IX+hero.base.sprite)
    LD (HL), A ; ставим спрайт персонажа на карту
    RET

  ENDMODULE
