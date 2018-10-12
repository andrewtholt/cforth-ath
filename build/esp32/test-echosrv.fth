fl connect.fth
\ test-socket.fth
\ Example code for using client sockets
\ Connects to an SSH server (port 22) on localhost (127.0.0.1)
\ and reads/displays the identification message

1 constant SOCK_STREAM  \ from /usr/include/*/bits/socket_type.h
2 constant PF_INET      \ from /usr/include/*/bits/socket.h
0 constant IPPROTO_IP   \ from /usr/include/netinet/in.h

#16 constant /sockaddr
/sockaddr buffer: sockaddr  \ w.pf bew.port ip[4] padding[8]

-1 value socket-fd

: open-socket  ( -- )
   IPPROTO_IP SOCK_STREAM PF_INET socket dup 0< if 
        ." open-socket" cr
        . cr
   then 
   to socket-fd
;
: close-socket  ( -- )
   socket-fd 0>=  if
      socket-fd close-file
      -1 to socket-fd
   then
;

: connect-socket  ( 'ip port -- )
   sockaddr /sockaddr '0' fill   ( 'ip port )
   PF_INET sockaddr w!           ( 'ip port )
   sockaddr wa1+ be-w!           ( 'ip )
   sockaddr 2 wa+  4 move        ( )
   /sockaddr sockaddr socket-fd connect dup 0<  if
        ." connect-socket" cr
        . cr
   then
;

create host #192 c, #168 c, #10 c, #119 c,
-1 value port
#8080 to port

\ : probe-ssh  ( -- )
\    open-socket
\    host port connect-socket
\    pad $100 socket-fd h-read-file  ( actual )
\    dup ?posix-err                  ( actual )
\    pad swap type                   ( )
\    close-socket                    ( )
\ ;
