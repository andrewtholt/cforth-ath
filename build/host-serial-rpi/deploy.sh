#!/bin/bash

# set -x

PKG=$(ls -tr *.deb | tail -1)

echo "Copying "$PKG" to repo"

if [ -f "$PKG" ]; then
    scp $PKG 192.168.10.124:/var/www/debian/armhf
fi

echo "..done."

