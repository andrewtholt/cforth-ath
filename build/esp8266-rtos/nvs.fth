
variable db
0 value db-init-run

32 constant /db-buffer
/db-buffer buffer: db-buffer

db-buffer /db-buffer 2constant value-buffer

: db-init
    db-init-run 0= if
        ." Open db ..." cr
        db s" settings" db-open abort" ...  failed"

        ." ... done" cr
        value-buffer erase
        -1 to db-init-run
    then
;
: (get) { name nlen val vlen -- }

    db-init-run 0= abort" Init not run"

    val vlen erase
    db
    name nlen val vlen db-get
;

: (set) { name nlen val vlen -- }
    db-init-run 0= abort" Init not run"

    db
    name nlen val vlen
    db-put
;

: get
    safe-parse-word \ db Name len
    value-buffer

    (get) 0= if
        db-buffer count type cr
    else
        ." Not found" cr
    then
;

: set
    safe-parse-word
    safe-parse-word
    (set) 0<> if
        ." Failed" cr
    then
;

: .value
    db-buffer count type
;




