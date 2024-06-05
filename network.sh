#!/bin/sh -x

lan="$(ifconfig alc0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
lanStatus="$(ifconfig alc0 | grep status | awk '{ printf $2 }')"

wlan="$(ifconfig wlan0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
wlanStatus="$(ifconfig wlan0 | grep status | awk '{ printf $2 }')"

IP4_ZEROED="0.0.0.0"
IP4_BLANK=""

if [ "$wlan" == ${IP4_ZEROED} ] || [ "$wlan" == ${IP4_BLANK} ] || [ "$lanStatus" == "active" ]; then
    echo "<fc=#fffdd0>"
elif [ "$lan" == ${IP4_ZEROED} ] || [ "$lan" == ${IP4_BLANK} ] || [ "$wlanStatus" == "associated" ]; then
    echo "<fc=#fffdd0>"
else
    echo "<fc=#666666>"
fi
