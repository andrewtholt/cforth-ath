\needs multi fl tasking.fth

\ Tests and examples for cooperative multitasking

\ Global variable used by the test tasks
global counts
global counts1

\ Explicit creation of word and task
: do-count begin 1 counts +!  pause  again  ;
task: count-task
' do-count count-task fork
count-task wake


\ Combined creation of task with word to execute
background counter  begin  3 counts +!  pause  again  ;
background counter1  begin  2 counts1 +!  pause  again  ;

: .counts  ( -- )
    ." counts = " counts ? cr 
    ." counts1= " counts1 ? cr 
;

.counts
pause
.counts
pause
.counts

: run-background  ( -- )  begin 100 ms pause  key? until  key drop  ;

.( Type a key to return to prompt) cr
run-background
.counts

