s" dbtst.fth" $find [if]
    execute
[else]
    marker dbtst.fth
[then]

variable db
0 value init-run

32 constant /buffer
/buffer buffer: buffer

buffer /buffer 2constant value-buffer

: init
    init-run 0= if
        ." Open db ..." cr
        db s" settings" db-open abort" ...  failed"

        ." ... done" cr
        value-buffer erase
        -1 to init-run
    then
;

: set-tst
    init
    ." Set some data ..." cr
    db s" TEST" s" TWO" db-put abort" ... failed"
    ." ... done" cr

    db s" WIFI_SSID" s" HoltAtHome4" db-put abort" ... failed WIFI_SSID"
;

: get-tst
    init
    ." Get some data ..." cr
\    db s" TEST" buffer 32 db-get abort" ... failed"
    db s" TEST" value-buffer db-get abort" ... failed"
    ." ... done" cr

    ." Let's see it >" buffer count type ." <" cr
;
\
\ Usage:  get <name>
\
: get
    buffer 32 erase
    db
    safe-parse-word value-buffer db-get 0= if
        buffer count type cr
    else
        ." Not found." cr
    then
;

: set
    value-buffer erase
    db
    safe-parse-word
    safe-parse-word
    db-put 0<> if
        ." Error" cr
    then

;

: tst
    init
    set-tst
    get-tst
;


