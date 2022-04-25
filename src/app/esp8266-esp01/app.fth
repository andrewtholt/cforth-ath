\ Load file for application-specific Forth extensions
.( HELLO ESP01 ) cr cr
fl ../../lib/misc.fth
fl ../../lib/dl.fth
fl ../../lib/random.fth

warning @ warning off
: bye standalone?  if  restart  then  bye  ;
warning !
: ms  ( msecs -- )  start-ms rest  ;

: relax  ( -- )  1 ms  ;  \ Give the system a chance to run

\ Long-running words like "words" can cause watchdog resets unless
\ we return to the OS periodically.
: paused-exit?  ( -- flag )  standalone?  if  relax  then  key?  ;
' paused-exit? to exit?

\ m-emit is defined in textend.c
alias m-key  key
alias m-init noop

: m-avail?  ( -- false | char true )
   key?  if  key true exit  then
   relax
   false
;
alias get-ticks timer@
: ms>ticks  ( ms -- ticks )  #1000 *  ;

fl xmifce.fth
fl ../../lib/crc16.fth
fl ../../lib/xmodem.fth
also modem
: rx  ( -- )  pad  unused pad here - -  (receive)  #100 ms  ;
previous

0 [if]
: .conntype  ( n -- )
   case  0 of  ." NONE"  endof  $10 of  ." TCP" endof  $20 of ." UDP" endof  ( default ) dup .x endcase
;
: .connstate  ( n -- )
   case  0 of ." NONE" endof 1 of ." WAIT" endof 2 of ." LISTEN" endof 3 of ." CONNECT" endof
         4 of ." WRITE" endof 5 of ." READ" endof 6 of ." CLOSE" endof  dup .x
   endcase
;
: .espconn  ( adr -- )
   dup .  dup l@ .conntype space  dup 1 la+ l@ .connstate space dup 2 la+ l@ .ip/port  6 la+ l@ ." Rev: " .x cr
;
[then]

0 constant gpio-input
1 constant gpio-output
2 constant gpio-interrupt

0 constant gpio-int-disable
1 constant gpio-int-posedge
2 constant gpio-int-negedge
3 constant gpio-int-anyedge
4 constant gpio-int-lolevel
5 constant gpio-int-hilevel

fl files.fth
\ fl ../../sensors/vl6180x.fth
\ fl ../../sensors/ds18x20.fth
\ fl ../../sensors/ads1115.fth
\ fl ../../sensors/bme280.fth
\ fl ../../sensors/pca9685.fth
\ fl hcsr04.fth

fl wifi.fth

fl ../../lib/redirect.fth
fl tcpnew.fth

fl ../../lib/url.fth
\ fl serve-sensors.fth
\ fl serve-hcsr04.fth

\ fl car2.fth

\ Measures NTC thermistor on channel 2 pulled up with 10K
\ against 2:1 voltage divider on channel 3.
: ads-temp@  ( -- n )  3 ads-channel@ w->n  ;

\ i.scl i.sda
\ 
: init-i2c  ( -- )  1 2 i2c-setup  ;

: .commit  ( -- )  'version cscount type  ;

: .built  ( -- )  'build-date cscount type  ;

: banner  ( -- )
   cr ." CForth built " .built
   ."  From " .commit
   cr
;

\ Replace 'quit' to make CForth auto-run some application code
\ instead of just going interactive.
\ : app  banner  hex init-i2c  showstack  quit  ;
: interrupt?  ( -- flag )
   ." Type a key within 2 seconds to interact" cr
   #20 0  do  key?  if  key drop  true unloop exit  then  #100 ms  loop
   false
;
: load-startup-file  ( -- )  " start" included   ;

fl ${CBP}/lib/mqtt.fth

: app
   banner  hex
   interrupt?  if  quit  then
   init-i2c
   ['] load-startup-file catch drop
   quit
;

alias id: \

fl ${CBP}/lib/fb.fth
fl ${CBP}/lib/font5x7.fth
fl ${CBP}/lib/ssd1306.fth
: init-wemos-oled  ( -- )
   1 2 i2c-setup
   ssd-init
;
: test-wemos-oled  ( -- )
   init-wemos-oled
   #20 0  do  i (u.)  fb-type "  Hello" fb-type  fb-cr  loop
;

0 [if]
\ Open Firmware stuff; omit if you don't need it
fl ${CBP}/ofw/loadofw.fth      \ Mostly platform-independent
fl ofw-rootnode.fth \ ESP8266-specific

fl sdspi.fth

-1 value hspi-cs   \ -1 to use hardware CS mode, 8 to use pin8 with software

' spi-transfer to spi-out-in
' spi-bits@    to spi-bits-in

: sd-init  ( -- )
   0 true #100000 hspi-cs spi-open
   ['] spi-transfer to spi-out-in
   ['] spi-bits@    to spi-bits-in
   sd-card-init
;
[then]

4 constant eth-cs-gpio  \ Depends on hardware wiring
\ The MAC address of my first-article Sun2 Ethernet card
create s2mac  8 c, 0 c, $20 c, 1 c, 2 c, $5b c,
: start-net  ( -- )
   s2mac eth-cs-gpio open-ethernet drop
;

" app.dic" save
