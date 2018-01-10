MODULE globaldata

; глобальные данные движка, не связанные с логикой игры
;( следовательно их не нужно сохранять в файле отгрузки )

frame_current defb 00; сколько тиков насчитали за один проход скрипта
frame_counter defb 00; считаем проходящие 1/50 тики

system_flags defb 0;

;таблица экранных адресов
SCREEN_ADDR_TABLE:
   DUP scrWidth * scrHeight;
   db 00, 00
   EDUP

ENDMODULE
