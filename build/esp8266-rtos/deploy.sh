#!/bin/bash

set -x

if [ $# -eq 0 ]; then
    export COMPORT=/dev/ttyUSB2
else 
    export COMPORT=$1
fi

rm -f extend.o
rm -f sdk_build/build/esp8266-rtos.elf && make sdk_build/build/esp8266-rtos.elf && ./flash.sh

