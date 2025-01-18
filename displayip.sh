#!/bin/sh -x

# wired
lan="$(ifconfig alc0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
lanStatus="$(ifconfig alc0 | grep status | awk '{ printf $2 }')"
# wireless
wlan="$(ifconfig wlan0 | grep inet | sed -e "s/\\t//g" | awk '{ printf $2 }')"
wlanStatus="$(ifconfig wlan0 | grep status | awk '{ printf $2 }')"

vmNetwork="$(ifconfig vm-public | grep inet | awk '{ printf $1 " " $2 }')"
vmNetmask="$(ifconfig vm-public | grep inet | awk '{ printf $3 " " $4 }')"

if [ "$wlan" == "0.0.0.0" ] || [ "$wlan" == "" ] || [ "$lanStatus" == "active" ]; then
    # echo " ${lan}"
    # herbe "Ethernet Interface" "$(ifconfig alc0 | grep inet | awk '{ printf "\n" $1 " " $2 "\n" $3 " " $4 "\n" $5 " " $6 }')"
    herbe "[Ethernet Interface]" "$(ifconfig alc0 | grep inet | awk '{ printf $1 " " $2 "\n" $3 " " $4 }')" \
          " " "[Virtual Network]" "${vmNetwork}" "${vmNetmask}"
elif [ "$lan" == "0.0.0.0" ] || [ "$lan" == "" ] || [ "$wlanStatus" == "associated" ]; then
    # echo " ${wlan}"
    # herbe "WiFi Interface" "$(ifconfig wlan0 | grep inet | awk '{ printf "\n" $1 " " $2 "\n" $3 " " $4 "\n" $5 " " $6 }')"
    herbe "[WiFi Interface]" "$(ifconfig wlan0 | grep inet | awk '{ printf $1 " " $2 "\n" $3 " " $4 }')" \
          " " "[Virtual Network]" "${vmNetwork}" "${vmNetmask}" 
else
    herbe "no connection"
fi

