#!/bin/bash

# set -x

echo 
COMPORT="NONE"
VERBOSE="NO"

while getopts fda:ht:v flag; do
    case $flag in
        v)
            VERBOSE="YES"
            ;;
        f)
            ARGS="flash"
            ;;
        a)
            ARGS="$OPTARG ${ARGS}"
            ;;
        d)
            DRY_RUN="YES"
            MAKE_FLAGS="-n $MAKE_FLAGS"
            ;;
        h)
            echo "Help."
            printf "\t-a <makefile args>\n"
            printf "\t-d\t\tDry run.\n"
            printf "\t-f\t\tFlash.  Need to specify port with -t\n"
            printf "\t-t <port>\tSerial port.\n"
            printf "\t-h\t\tHelp.\n"

            exit 0
            ;;
        t)
            COMPORT=$OPTARG
            export COMPORT
            ;;
    esac
done

export IDF_PATH=/home/andrewh/esp/esp-idf
TOOLS="/home/andrewh/esp/xtensa-esp32-elf/bin"

export PATH=$PATH:$TOOLS

if [ "$DRY_RUN" = "YES" ]; then
    echo
    echo "DRY RUN"
    MAKE_FLAGS="-n ${MAKE_FLAGS}"
    echo
fi
#EAGLE="$HOME/Source/Forth/nodemcu-firmware/app/.output/eagle/debug/image/eagle.app.v6.out"
#
#if [ -f $EAGLE ]; then
#    echo "remove Eagle"
#    rm -f $EAGLE
#fi
#
# make -j4 $MAKE_FLAGS $ARGS
if [ "$ARGS" = "clean" ]; then
    echo "Clean"
    rm -f *.bin
fi

CMD=""
if [ "$ARGS" == "download" ]; then
    echo $COMPORT
    if [  "$COMPORT" == "NONE" ]; then
        echo "Error"
        echo "Set comport using -t switch"
        exit 1
    else
        CMD="COMPORT=$COMPORT"
    fi
fi

set -x
CMD="$CMD make $MAKE_FLAGS $ARGS"
echo $CMD
eval "$CMD"

