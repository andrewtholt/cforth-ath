s" dbtst.fth" $find [if]
    execute
[else]
    marker dbtst.fth
[then]

variable db
0 value init-run

32 buffer: buffer

: init
    init-run 0= if
        ." Open db ..." cr
        db s" settings" db-open abort" ...  failed"

        cr db @ . cr
        ." ... done" cr
    then
;

: set-tst
    ." Set some data ..." cr
    db s" TEST" s" TWO" db-put abort" ... failed"
    ." ... done" cr
;

: get-tst
    ." Get some data ..." cr
    db s" TEST" buffer 32 db-get abort" ... failed"
    ." ... done" cr

    ." Let's see it >" buffer count type ." <" cr
;



: tst
    init
    set-tst
    get-tst
;


