.( MQTT settings ) cr

: server$  ( -- $ )  " 192.168.10.124"  ;    
    
: mqtt-server$  ( -- $ )  " server$" evaluate  ;    

: default-client-id$  ( -- $ )  " MQTT Forth"  ;

defer mqtt-client-id$

' default-client-id$ to mqtt-client-id$

: mqtt-username$  ( -- $ )  " "  ;    
: mqtt-password$  ( -- $ )  " "  ;    
: mqtt-will$  ( -- msg$ topic$ )  " "  " "  ;    
0 value mqtt-will-qos     \ 0, 1, 2, 3    
0 value mqtt-will-retain  \ 0 or 1    
0 value mqtt-clean-session    
0 value mqtt-keepalive    \ seconds

