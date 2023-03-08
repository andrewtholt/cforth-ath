#!/bin/bash

set -x

esptool.py --port /dev/ttyUSB2 --baud 115200 write_flash --flash_mode dout --flash_size detect 0x0 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/build/bootloader/bootloader.bin 0x10000 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/build/esp8266-rtos.bin 0x8000 /home/andrewh/Source/Forth/cforth-ath/build/esp8266-rtos/build/partitions.bin

