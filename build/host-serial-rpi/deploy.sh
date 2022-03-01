#!/bin/bash

set -x

PKG=$(ls -tr *.deb | tail -1)

if [ -f "$PKG" ]; then
    scp $PKG 192.168.10.124:/var/www/debian/armhf
fi


