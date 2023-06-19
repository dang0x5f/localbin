#!/bin/sh -x

# wired
lan="$(ifconfig alc0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
lanStatus="$(ifconfig alc0 | grep status | awk '{ printf $2 }')"
# wireless
wlan="$(ifconfig wlan0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
wlanStatus="$(ifconfig wlan0 | grep status | awk '{ printf $2 }')"

if [ "$wlan" == "0.0.0.0" ] || [ "$wlan" == "" ] || [ "$lanStatus" == "active" ]; then
#    echo " ${lan}"
    echo " LAN"
elif [ "$lan" == "0.0.0.0" ] || [ "$lan" == "" ] || [ "$wlanStatus" == "associated" ]; then
#    echo " ${wlan}"
    echo " WLAN"
else
    echo " no connection"
fi
