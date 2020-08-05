4 constant g0
0 value my-timer
#100 value period

: change
   g0 gpio-pin@ 0= g0 gpio-pin!
;

: init
   pullup gpio-output g0 gpio-mode     
   ['] change new-timer to my-timer 
   period 1 1 my-timer arm-timer   
;
 
: deinit
   my-timer disarm-timer
   pullup gpio-input g0 gpio-mode
;
