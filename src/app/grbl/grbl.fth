\ Sends GCode to a GRBL CNC controller
\ ok send MyFile.gcode

\ Verbosity controls
false value show-gcode?   \ Show GCode lines as they are sent
false value show-ack?     \ Show OK/Error ack lines as they are received
false value show-line#?   \ Show how many lines have been executed and how many are queued
false value show-buf?     \ Show the space left in GRBL's Rx buffer
true value show-time?     \ Show the elapsed time in seconds

0 value comport  \ File handle for serial port

: flush-grbl  ( -- )
   pad #1000  #500 comport timed-read-com pad swap type
;
: open-grbl  ( -- )
   comport if exit then
   0 open-com to comport
   comport 0< abort" Can't open serial port"
   #115200 comport baud
   flush-grbl
   #2000 ms
   flush-grbl
;
: send-gcode-line  ( adr len -- )  comport write-com drop  ;

\ A couple of convenience words for interactive testing
: r  pad #100  #100 comport timed-read-com  pad swap type  ;
: w  0 parse  send-gcode-line  " "n" send-gcode-line  r r  ;

#128 constant /rxbuf           \ The size of GRBL's Rx buffer, determined externally

/rxbuf cells buffer: linelens  \ Array of lengths of lines queued in GRBL's Rx buffer
0 value #queued-lines          \ The number of lines queued in GRBL's Rx buffer
0 value bufavail               \ Current free bytes in GRBL's Rx buffer

0 value sent-line#             \ The number of lines that have been sent so far
0 value executed-line#         \ The number of lines that have been executed so far

0 value time0                  \ Start time in milliseconds

\ Show some statistics
: .stats  ( -- )
   show-line#?  if  executed-line# .d  sent-line# executed-line# - .d   then
   show-buf?  if  bufavail .d   then
   show-time?  if  get-msecs time0 - #1000 / .d  then
   #out @  if  (cr  then
;

\ Remove a line from the queued list and increase the buffer count by its length
\ Called with an ack ('ok') is received from GRBL
: -line  ( -- )
   #queued-lines 0=  if  exit  then
   bufavail  linelens @  + to bufavail
   #queued-lines 1- to #queued-lines
   linelens cell+  linelens  #queued-lines cells move
   executed-line# 1+ to executed-line#
;

\ Add a line from the queued list and decrease the buffer count by its length
\ Called when a line is sent to GRBL
: +line  ( linelen -- )
   dup  linelens #queued-lines cells + !  ( linelen )
   bufavail swap -  to bufavail
   #queued-lines 1+ to #queued-lines
   sent-line# 1+ to sent-line#
;

/rxbuf 2+ buffer: the-line     \ The next line to be sent to GRBL

/rxbuf buffer: response-buf    \ Buffer to accumulate response lines from GRBL
0 value #response              \ The number of bytes in response-buf

\ Remove trailing carriage return, if present
: -cr  ( $ -- $' )
   ?dup  0=  if  exit  then  ( $ )
   2dup 1- +  c@  #13  =  if  1-  then   ( $- )
;

\ Interpret GRBL response data
: parse-response  ( -- )
    response-buf #response " "(0a)" lex  if          ( tail$ head$ char )
       \ The response data contains a complete line
       drop                                          ( tail$ head$ )

       \ If the response line isn't empty, record that a queued line has been processed
       -cr   ?dup  if  -line  then                   ( tail$ head$ )

       2dup  " ok"  compare  if                      ( tail$ head$ )
          \ Display error lines
          type cr                                    ( tail$ )
       else                                          ( tail$ head$ )
          \ Show ok acks only if asked to
	  show-ack?  if  type cr  else  2drop  then  ( tail$ )
       then                                          ( tail$ )

       \ If there is any trailing data in the response buffer, move it to the beginning
       to #response  response-buf #response move     ( )

    else                                             ( $ )
       \ No linefeed; so far the line is incomplete
       2drop                                         ( )
    then                                             ( )
;

\ Handle GRBL response if available
: handle-rx  ( -- )
   response-buf  /rxbuf #response -  #1 comport timed-read-com  dup 0<  if  ( actual | -1 )
      drop                          ( )
   else                             ( actual )
      #response +  to #response     ( )
   then                             ( )
   parse-response
;

\ Wait until there is room in GRBLs Rx buffer, meanwhile handling events
: wait-ready  ( -- )   begin  handle-rx   bufavail 0>  until  ;

0 value fid
0 value linelen

\ Get one GCode line from the input file and send it when GRBL has room
: send-line  ( -- done? )
   the-line /rxbuf fid read-line abort" Read failed"  ( actual more? )
   0=  if  drop true  exit  then                      ( actual )
   #10 the-line 2 pick + c!  1+ to linelen            ( )
   linelen +line                                      ( )
   wait-ready                                         ( )
   show-gcode?  if  the-line linelen type  then       ( )
   the-line linelen send-gcode-line                   ( )
   .stats                                             ( )
   false                                              ( false )
;

\ Send a GCode file to GRBL
: $send-file  ( filename$ -- )
   open-grbl

   0 to #queued-lines
   0 to sent-line#
   0 to executed-line#
   /rxbuf to bufavail
   get-msecs to time0

   r/o open-file abort" Can't open input file" to fid
   begin  send-line  until
   fid close-file drop
;

: send  ( "filename" -- )  safe-parse-word $send-file  ;

: t " LogoArray.gcode" $send-file  ;