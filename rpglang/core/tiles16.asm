; модуль вывода тайлов 2x2 знакоместа ( 16 x16 пикселов  )
; для работы надо установить sprArray - указатель на массив тайлов
  MODULE Tiles16

  MACRO Tiles16.setTiles spr_ptr
    LD HL, spr_ptr
    LD (Tiles16.sprArray), HL
  ENDM

  MACRO Tiles16.showTile xy, spr
    LD DE, xy
    LD A, spr
    CALL Tiles16.show_tile
  ENDM

; переводим индекс карты в указатель на начало данных спрайта
; A - номер спрайта
; на выходе HL - указатель на данные спрайта
; затрагивается регистр BC!!!
  MACRO spr_index_to_addr
   LD L, A
   LD H, 0; загружаем номер спрайта в HL
   ADD HL,HL; x2
   ADD HL,HL; x4
   PUSH HL; // запоминаем x4
   ADD HL,HL; x8
   ADD HL,HL; x16
   ADD HL,HL; x32
   POP BC; // снимаем со стека x4 - еще 4 байта цветности
   ADD HL, BC
   LD BC, (sprArray); указатель на начало спрайтов
   ADD HL, BC
  ENDM

;показываем 1 тайл на карте
;HL - указатель на спрайт
;DE - экранный адрес
show_tile_on_map:
   PUSH DE
 // thanks to Alone Coder!
   LD B,8
_my_spr_loop_1:
   LDI // LD (DE),(HL)  DE+1, HL+1, BC-1
   LD A,(HL)
   LD (DE),A
   DEC E
   INC D
   INC HL
   DJNZ _my_spr_loop_1

   POP DE
   PUSH DE

   LD BC, 32
   EX HL, DE
   ADD HL, BC
   EX HL, DE; DE = DE + 32

   LD B, 8
_my_spr_loop_2:
     LDI // LD (DE),(HL)  DE+1, HL+1
     LD A,(HL)
     LD (DE),A
     DEC E
     INC D
     INC HL
     DJNZ _my_spr_loop_2

     POP DE; // original screen position

     PUSH HL
     call math.addr_to_attr
     LDI
     LDI
     POP HL
     LD A,E
     ADD A,30; нижний ряд ( 30 а не 32 так как 2 уже прибавили выше )
     LD E,A
     LDI
     LDI
     RET

 ; по текущему адресу тайла на экране получаем адрес тайла справа от него
 ; в DE - адрес тайла на экране
 ; на выходе в DE адрес следующего справа тайла на экране
 MACRO next_tile_pos_right
  INC E
  INC E
 ENDM

 MACRO next_tile_pos_down
  LD A, #20+#20 ; 64
  ADD A,E
  LD E,A
  JR NC, next_tile_pos_down_exit
  ; переполнение - значит мы перешли на другую треть, прибавляем 8 к D
  LD E,00
  LD A, #8
  ADD A,D
  LD D,A
next_tile_pos_down_exit:
  ;LD E,A
; если есть переполнение - значит мы вышли за границу трети экрана, смотрим куда попали
 ENDM

; программа показывает на экране карту тайлов
; в HL - адрес первого тайла на карте
show_tile_map:
  LD DE, SCREEN_ADDR ; current pos draw variable
  LD B, scrHeight
show_tile_map_loop2: ; цикл по столбцам
  PUSH BC
  PUSH HL; ---- запоминаем все в стек
  PUSH DE

; ------------ рисуем строку тайлов -------------
  LD B, scrWidth
show_tile_map_loop1: ; цикл по строкам
  PUSH BC
  PUSH HL; ---- запоминаем все в стек
  PUSH DE

  LD A,(HL)
  spr_index_to_addr
  call show_tile_on_map
  POP DE; ---- снимаем все со стека
  next_tile_pos_right
  POP HL
  INC HL; сдвигаем указатель на ячейку карты влево
  POP BC
  DJNZ show_tile_map_loop1
; ------------ закончили рисовать строку тайлов -------------

  POP DE
  next_tile_pos_down
  POP HL; ---- снимаем все со стека
  LD BC, mapSize
  ADD HL, BC; прибавляем к указателю на начало тайлов ширину - сдвигаем указатель вниз на 1 тайл
  POP BC
  DJNZ show_tile_map_loop2

  RET

; программа показывает один тайл на экране
; Вход: DE - координаты тайла в позициях тайлов
; A - номер спрайта
show_tile:

  LD HL, DE ; DE x 2 - у нас ширина спрайта =2, то есть позиция 1x1 будет 2x2 в знакоместах
  ADD HL, HL
  LD DE, HL

  LD L, A
  LD H, 0; загружаем номер спрайта в HL
  ADD HL,HL; x2
  ADD HL,HL; x4
  PUSH HL; // запоминаем x4
  ADD HL,HL; x8
  ADD HL,HL; x16
  ADD HL,HL; x32
  POP BC; // снимаем со стека x4 - еще 4 байта цветности
  ADD HL, BC
p_sprArray:
  LD BC, #0000;
  ADD HL, BC
  call math.pos_scr
  PUSH DE

// thanks to Alone Coder!
  LD B,8
spr_loop_1
  LDI // LD (DE),(HL)  DE+1, HL+1, BC-1
  LD A,(HL)
  LD (DE),A
  DEC E
  INC D
  INC HL
  DJNZ spr_loop_1

  POP DE
  PUSH DE

  LD BC, 32
  EX HL, DE
  ADD HL, BC
  EX HL, DE; DE = DE + 32

  LD B, 8
spr_loop_2
    LDI // LD (DE),(HL)  DE+1, HL+1
    LD A,(HL)
    LD (DE),A
    DEC E
    INC D
    INC HL
    DJNZ spr_loop_2

  /* LD A, #10; number of sprite lines
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL math.down_line; в DE адрес опускаем на линию ниже
  EX AF,AF'
  DEC A
  JR NZ,spr_loop_1 */

  POP DE; // original screen position
  call math.addr_to_attr
  LDI // LD (DE),(HL)
  LDI // LD (DE),(HL)
  PUSH HL
  ;LD BC, 30
  ;EX DE, HL
  ;ADD HL, BC
  ;EX DE, HL
  LD a,e
  ADD a,30
  LD e,a
  JR NC, no_down8
  LD a,d
  ADD a,8
  LD d,a
no_down8:
  POP HL
  LDI
  LDI
  RET

sprArray EQU p_sprArray+1

  ENDMODULE
