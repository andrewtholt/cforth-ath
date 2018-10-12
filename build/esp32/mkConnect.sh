#!/bin/bash
if [ -z "$WIFI_BASE" ]; then
    echo "Set WIFI_BASE"
    exit
fi


if [ -z "$WIFI_PASSWORD" ]; then
    echo "Set WIFI_PASSWORD"
    exit
fi


echo ":noname \" ${WIFI_BASE}\" ; to wifi-sta-ssid"
echo ":noname \" ${WIFI_PASSWORD}\" ; to wifi-sta-password"

echo "wifi-sta-on"

