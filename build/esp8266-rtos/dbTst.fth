s" dbtst.fth" $find [if]
    execute
[else]
    marker dbtst.fth
[then]

requires nvs.fth

: set-tst
    ." Set some data ..." cr
    db s" TEST" s" TWO" db-put abort" ... failed"
    ." ... done" cr

    db s" WIFI_SSID" s" HoltAtHome4" db-put abort" ... failed WIFI_SSID"
;

: get-tst
    ." Get some data ..." cr
\    db s" TEST" buffer 32 db-get abort" ... failed"
    db s" TEST" value-buffer db-get abort" ... failed"
    ." ... done" cr

    ." Let's see it >" .value cr
;

: tst
    db-init
    set-tst
    get-tst
;

