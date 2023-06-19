#!/bin/sh -x

# wired
lan="$(ifconfig alc0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
lanStatus="$(ifconfig alc0 | grep status | awk '{ printf $2 }')"
# wireless
wlan="$(ifconfig wlan0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
wlanStatus="$(ifconfig wlan0 | grep status | awk '{ printf $2 }')"

if [ "$wlan" == "0.0.0.0" ] || [ "$wlan" == "" ] || [ "$lanStatus" == "active" ]; then
#    echo " ${lan}"
    herbe "LAN Interface" "$(ifconfig alc0 | grep inet | awk '{ printf "\n" $1 " " $2 "\n" $3 " " $4 "\n" $5 " " $6 }')"
elif [ "$lan" == "0.0.0.0" ] || [ "$lan" == "" ] || [ "$wlanStatus" == "associated" ]; then
#    echo " ${wlan}"
    herbe "WLAN Interface" "$(ifconfig wlan0 | grep inet | awk '{ printf "\n" $1 " " $2 "\n" $3 " " $4 "\n" $5 " " $6 }')"
else
    herbe "no connection"
fi
