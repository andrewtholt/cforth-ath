#!/bin/bash

set -x

# esptool.py --port <serial-port-of-ESP8266> write_flash -fm <flash-mode> 0x00000 <nodemcu-firmware>.bin
esptool.py --port /dev/ttyUSB0 write_flash  0x00000 <nodemcu-firmware>.bin
