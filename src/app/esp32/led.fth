
#02 constant led

: gpio-out-off  ( gpio# -- )  0 over gpio-pin!  gpio-is-output  ;

: led-on
    1 led gpio-pin!
;


: led-off
    0 led gpio-pin!
;



