#!/bin/bash

set -x

BAUD=
python /home/andrewh/Source/Forth/ESP8266_RTOS_SDK/components/esptool_py/esptool/esptool.py --chip esp8266 --port ${COMPORT} --baud 115200 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 40m --flash_size 4MB 0x0 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/sdk_build/build/bootloader/bootloader.bin 0x10000 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/sdk_build/build/esp8266-rtos.bin 0x8000 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/sdk_build/build/partitions.bin

