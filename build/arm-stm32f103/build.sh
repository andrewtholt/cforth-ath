#!/bin/bash

set -x

PATH="/home/andrewh/bin:/home/andrewh/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin:."

PATH="/usr/local/gcc-arm-none-eabi-9-2019-q4-major/bin:${PATH}"

export PATH

make

