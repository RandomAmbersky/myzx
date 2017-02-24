  MODULE map

; тестовая функция заполняет спрайтами карту по очереди от 0 до 256 и далее опять 0...
map_size equ 16
init_map_spr:
  LD A, map_size; ширина
  LD (my_map.width), A
  LD (my_map.height), A
  LD HL, my_map+str_map_header; ставим указатель на данные карты
  LD BC, map_size * map_size; ширина x высота
  LD E, #00
init_map_loop:
  LD (HL),E
  INC HL
  INC E
  DEC BC
  LD A,B
  OR C
  JR NZ,init_map_loop;
  RET

; процедуры обсчета движения на карте
; фактически - проверка на выход за левые, правые, верхние и нижние границы карты
MAP_POS str_map_point 0,0; обсчитываемая процедурой точка
MAP_ADDR defw 0; адрес на карте считаемый по MAP_POS процедурой map_pos_to_addr

pos_up:
  LD A, (MAP_POS.posY)
  DEC A
  RET M; позиция по Y не может быть меньше нуля
  LD (MAP_POS.posY), A
  RET

pos_down:
  LD A, (my_map.height)
  LD E, A
  LD A, (MAP_POS.posY)
  INC A
  CP E
  RET NC
  LD (MAP_POS.posY), A
  RET

pos_left:
  LD A, (MAP_POS.posX)
  DEC A
  RET M
  LD (MAP_POS.posX), A
  RET

pos_right:
  LD A, (my_map.width)
  LD E, A
  LD A, (MAP_POS.posX)
  INC A
  CP E; размер экрана нашего по Y
  RET NC
  LD (MAP_POS.posX), A
  RET

; пересчитываем значение из MAP_POS в адрес, указывающий
; на верхнюю левую ячейку карты, отображаемой на экране
; в котором спрайт из MAP_POS стоит как бы в центре :)
pos_to_window_addr:
  LD BC, #0608; 1/2 размера экрана в спрайтах по Y и X
pos_x_min_to_window:
  LD A, (MAP_POS.posX)
  SUB B; // половина нашего окна по Y
  JP P,map_pos_x_max_to_window; если позиция больше чем половина карты - то все нормально, переходим к проверке на макс. по Y
  LD H,C;
  JR
pos_x_0_to_window:
pos_x_max_to_window:

pos_y_min_to_window:
pos_y_max_to_window:

  LD DE, my_map+str_map_header
  LD (MAP_ADDR), DE
  RET

; функция показа карты
; в HL -  указатель на начало карты
show:
  LD BC, #100C ; width and height screen - 16 x 12
  LD DE, #0000 ; current pos draw variable
loop2:
  PUSH BC
  PUSH HL
loop:
  PUSH DE
  PUSH BC
  PUSH HL
  LD A,(HL)
  call show_sprite
  POP HL
  INC HL
  POP BC
  POP DE
  INC D
  DJNZ loop;
  LD D, #00
  INC E
  POP HL; //origin map pointer
  LD B, 0
  LD A, (my_map.width)
  LD C, A
  ;LD C, (my_map.width)
  ;DEC C
  ;LD C, 32
  ADD HL, BC; увеличиваем смещение указателя карты на 32 - ширину экрана
  POP BC; //origin
  DEC C
  JR NZ, map_loop2
  RET

; программа показывает один спрайт на карте
; Вход: DE - позиция в координатах экрана
;       A - номер спрайта
show_sprite:

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
  LD BC, SPR_BEGIN;
  ADD HL, BC;

  call screen_calc_scr_addr_DE
  PUSH DE
  LD A, #10; number of sprite lines
spr_loop_1
  PUSH DE
  LDI
  LDI
  POP DE
  EX AF,AF'
  CALL screen_calc_down_DE; в DE адрес опускаем на линию ниже
  EX AF,AF'
  DEC A
  JR NZ,spr_loop_1

  POP DE; // original screen position
  call screen_addr_to_attr_DE
  LDI
  LDI
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

  ENDMODULE
