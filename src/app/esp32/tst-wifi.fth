:noname " HoltAtHome4" ; to wifi-sta-ssid
:noname " password" ; to wifi-sta-password

wifi-sta-on

fl ../../cforth/printf.fth
#100 buffer: abort-msg

: sprintf-abort  ( ? pattern$ -- )
   sprintf abort-msg pack  'abort$ !
   -2 throw
;

\needs wbsplit  : wbsplit  ( w -- b.low b.high )  ;
\needs be-w! : be-w!  ( w adr -- )  >r  wbsplit r@ c! r> 1+ c!  ;

: ?posix-err  ( n -- )
   0<  if
      \ EALREADY is not really a problem
      errno  dup #114 =  if  drop exit  then
      dup >r strerror cscount r>
      " Syscall error %d: %s" sprintf-abort
   then
;

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
   IPPROTO_IP SOCK_STREAM PF_INET socket dup ?posix-err to socket-fd
;
: close-socket  ( -- )
   socket-fd 0>=  if
      socket-fd h-close-handle
      -1 to socket-fd
   then
;

: connect-socket  ( 'ip port -- )
   sockaddr /sockaddr '0' fill   ( 'ip port )
   PF_INET sockaddr w!           ( 'ip port )
   sockaddr wa1+ be-w!           ( 'ip )
   sockaddr 2 wa+  4 move        ( )
   /sockaddr sockaddr socket-fd connect  ?posix-err
;

create host #127 c, 0 c, 0 c, 1 c,
\ #22 constant port
#8080 constant port

: probe-ssh  ( -- )
   open-socket
   host port connect-socket
   pad $100 socket-fd h-read-file  ( actual )
   dup ?posix-err                  ( actual )
   pad swap type                   ( )
   close-socket                    ( )
;
