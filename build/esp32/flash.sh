#!/bin/bash

set -x

python /home/andrewh/Source/Forth/esp-idf-v3.1.4/components/esptool_py/esptool/esptool.py --chip esp32 --port /dev/ttyUSB2 --baud 115200 --before default_reset --after hard_reset write_flash -u --flash_mode dio --flash_freq 40m --flash_size detect 0x1000 /home/andrewh/Source/Forth/cforth-ath/build/esp32/sdk_build/build/bootloader/bootloader.bin 0x10000 /home/andrewh/Source/Forth/cforth-ath/build/esp32/sdk_build/build/forth.bin 0x8000 /home/andrewh/Source/Forth/cforth-ath/build/esp32/sdk_build/build/partitions.bin
