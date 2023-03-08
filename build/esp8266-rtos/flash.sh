#!/bin/bash
set -x
COMPORT=/dev/$1 ESPBAUD=115200 make flash

