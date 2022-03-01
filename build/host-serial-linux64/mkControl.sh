#!/bin/bash
# set -x
VERSION=$(cat ./version.txt)

HW=$(uname -m)

if [ $HW = "x86_64" ]; then
    HW=amd64
fi

if [ $HW = "armv7l" ]; then
    HW=armhf
fi

if [ $HW = "aarch64" ]; then
    HW=arm64
fi



echo "Package: cforth"
echo "Section: misc"
echo "Priority: extra"
echo "Maintainer: Andrew Holt"
echo "Architecture: $HW"
echo "Version: $VERSION"
echo "Description: Mitch Bradleys cforth"
echo "    1.0.0 first package"
echo "    1.0.1 Added forth script"
echo "    2.0 AFter merge with master"
echo "    2.1 Some news words and sync across platforms."
echo "    2.2 MQTT"
echo "    2.2.1 defer mqtt-client-id$"
echo "    2.2.2 Added system."
echo "    2.2.4 Added ipaddr."
echo "    2.2.5 Removed dubug from ipaddr."
