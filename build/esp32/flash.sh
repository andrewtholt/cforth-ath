#!/bin/bash

set -x


COMPORT=/dev/ttyUSB1 ESPBAUD=19200 make flash
