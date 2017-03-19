  MODULE Sound

beep:
  LD DE,440
  LD HL,964
  CALL  949
  RET


skrebok:
  DI
  LD B, 30
  LD A, 24
  call skrebok_snd
  LD B, 30
  LD A, 0
  call skrebok_snd
  LD B, 30
  LD A, 24
  call skrebok_snd
  LD B, 30
  LD A, 0
  call skrebok_snd
  LD B, 90
  LD A, 24
  call skrebok_snd
  LD B, 90
  LD A, 0
  call skrebok_snd
  EI

skrebok_snd:
  LD (skrebok_loop+1), A
skrebok_loop:
  LD A, 24
  OUT (254), A

  PUSH BC
  DJNZ $           ;цикл задержки
  POP BC

  XOR A
  OUT (254), A

  PUSH BC
  DJNZ $           ;цикл задержки
  POP BC

  DJNZ skrebok_snd
  RET


tweet:
  LD    B,100 ; длительность
  ;LD A,(23624)   ;определение цвета бордюра
  ;AND #38
  ;RRA
  ;RRA
  ;RRA
  LD A,7
  DI
TWEET1 XOR 16          ;переключение 4-го бита
       OUT (254),A
       PUSH BC
       DJNZ $           ;цикл задержки
       POP BC
       DJNZ TWEET1
       EI
       RET


vibr:  LD    H,100
       LD    E,10
       LD    B,4
       LD    L,1

        LD    A,(23624)
        AND   #38
        RRA
        RRA
        RRA
        LD    C,A
        DI
VIBR1  LD    D,E         ;продолжительность цикла спада (подъема)
VIBR2  LD    A,C
        XOR   16
        LD    C,A
        OUT   (254),A
        LD    A,H         ;изменение частоты звука
        ADD   A,L
        LD    H,A
VIBR3  DEC   A           ;цикл задержки
        JR    NZ,VIBR3
        DEC   D
        JR    NZ,VIBR2
        LD    A,L         ;смена направления изменения частоты
        NEG
        LD    L,A
        DJNZ  VIBR1
        EI
        RET

laser:
  LD    B,5
       LD    C,200
       LD    H,50
       LD    A,(23624)
       AND   #38
       RRA
       RRA
       RRA
       DI
LASER1 PUSH  BC
       LD    L,H
LASER2 XOR   16
       OUT   (254),A
       LD    B,H
       DJNZ  $
       INC   H           ;другой вариант - DEC H
       DEC   C
       JR    NZ,LASER2
       LD    H,L
       POP   BC
       DJNZ  LASER1
       EI
       RET

twoton:
  LD    BC,500      ;длительность звучания
  LD    D,0      ;высота первого тона
  LD    E,10       ;высота второго тона
  LD    A,(23624)
  AND   #38
  RRA
  RRA
  RRA
  LD    H,D
  LD    L,E
  DI
TWOTN1
    DEC   H           ;задержка для получения первого тона
    JR    NZ,TWOTN2
    XOR   16
    OUT   (254),A     ;извлечение первого звука
    LD    H,D         ;восстановление значения задержки
                          ; для первого тона
TWOTN2 DEC   L           ;задержка для получения второго тона
        JR    NZ,TWOTN1
        XOR   16
        OUT   (254),A     ;извлечение второго звука
        LD    L,E         ;восстановление значения задержки
                          ; для второго голоса
        PUSH  AF
        LD    A,B         ;проверка окончания звучания
        OR    C
        JR    Z,TWOTN3
        POP   AF
        DEC   BC
        JR    TWOTN1
TWOTN3 POP   AF
        EI
        RET

hiss:
  LD DE, 66
  LD A,(23624)
  AND   #38
  RRA
  RRA
  RRA
  LD    B,A
  LD    HL,0        ;начальный адрес ПЗУ
  DI
HISS1
  LD A,(HL)      ;берем байт в аккумулятор
  AND   16          ;выделяем 4-й бит
  OR    B           ;объединяем с цветом бордюра
  OUT   (254),A     ;получаем звук
  INC   HL          ;переходим к следующему байту
  DEC   DE          ;уменьшаем значение длительности
  LD    A,D
  OR    E
  JR    NZ,HISS1    ;переходим на начало,
                   ; если звук не закончился
  EI
  RET

crash:
  LD B, 40; продолжительность звучания
  LD    A,(23624)
       AND   #38
       RRA
       RRA
       RRA
       DI
       LD    HL,100      ;начальный адрес в ПЗУ
CRASH1 XOR   16
       OUT   (254),A     ;извлекаем звук
       LD    C,A         ;сохраняем значение аккумулятора
       LD    E,(HL)      ;получаем в паре DE
       INC   HL          ; продолжительность цикла задержки
       LD    A,(HL)
       AND   3           ;ограничиваем величину старшего байта
       LD    D,A
CRASH2 LD    A,D         ;цикл задержки
       OR    E
       JR    Z,CRASH3
       DEC   DE
       JR    CRASH2
CRASH3 LD    A,C         ;восстанавливаем значение аккумулятора
       DJNZ  CRASH1
       EI
       RET

explos
  ; B - количество повторений эффекта
  ; D - задается длительность звучания
  ; E начальную среднюю частоту.
      ;LD    B,1
       ;LD    D,100
       ;LD    E,-1

       LD    B,2
             LD    D,35
             LD    E,100

 LD    A,(23624)
        AND   #38
        RRA
        RRA
        RRA
        LD    L,A
        DI
EXPL1  PUSH  BC
        PUSH  DE
EXPL2  PUSH  DE
EXPL3  LD    B,E
        DJNZ  $           ;задержка
        LD    A,(BC)      ;в паре BC один из первых 256 адресов ПЗУ
        AND   16
        OR    L
        OUT   (254),A
        INC   C
        DEC   D
        JR    NZ,EXPL3
        POP   DE
       ; Изменение высоты шума (понижение среднего тона;
       ;  если заменить на DEC E, тон будет наоборот повышаться)
       INC   E
       DEC   D
       JR    NZ,EXPL2
       POP   DE
       POP   BC
       DJNZ  EXPL1       ;повторение всего эффекта
       EI
       RET

// only for 128-k spectrum
/*
melody:
  LD B,5
  LD IX, mel_data
mel1:
  PUSH BC
  LD BC, 65533
  LD A,(IX)
  INC IX
  OUT (C),A
  LD A,(IX)
  LD BC, 49149
  INC IX
  OUT (C),A
  POP BC
  DJNZ mel1
  RET
mel_data:
  defb 7
  defb %00000111
  defb 8
  defb %00011111
  defb 12
  defb 11
  defb 6
  defb %00000111
  defb 13
  defb %00000010
*/
  ENDMODULE
