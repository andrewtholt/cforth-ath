#!/bin/bash

set -x

if [ $# -ne 1 ]; then
    echo "Neead a port"
else
    TTY=$1
fi

rm -f /home/andrewh/Source/Forth/nodemcu-firmware/app/.output/eagle/debug/image/eagle.app.v6.out
rm -f *.bin *.dic
rm -f *.o forth

./build.sh

/home/andrewh/Source/Forth/cforth-ath/../nodemcu-firmware/tools/esptool.py --port $TTY -b 115200 write_flash -fm=dio -fs=32m 0x00000 0x00000.bin 0x10000 0x10000.bin
