#255 constant /size
/size buffer: fred

: tst
    uname

    fred /size hostname 

    fred count type cr

    fred /size os

    fred count type cr
;

tst

