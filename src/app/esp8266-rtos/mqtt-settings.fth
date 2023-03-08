.( MQTT settings ) cr

:noname ( -- $ )  " 192.168.10.124"  ; to mqtt-server$
:noname  ( -- $ )  " ESP8266 Forth"  ; to mqtt-client-id$

:noname  ( -- $ )  " "  ; to mqtt-username$
:noname  ( -- $ )  " "  ; to mqtt-password$

\ : mqtt-will$  ( -- msg$ topic$ )  " "  " "  ;    

defer mqtt-will$

0 value mqtt-will-qos     \ 0, 1, 2, 3    
0 value mqtt-will-retain  \ 0 or 1    
0 value mqtt-clean-session    
0 value mqtt-keepalive    \ seconds

