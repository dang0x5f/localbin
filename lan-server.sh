#!/bin/sh

server_name="cassiopeia"

success_str="1 packets transmitted, 1 packets received, 0.0% packet loss"
connection=`ping -c 1 ${server_name} | grep -i "${success_str}" | wc -l`

printStatus() {
    if [ ${connection} -gt 0 ]; then
        echo "<fc=#fffdd0>"
    else
        echo "<fc=#666666>"
    fi
}

printMessage() {
    if [ ${connection} -gt 0 ]; then
        addr=`traceroute ${server_name} | awk '{ print $3 }'`
        shares=`mount | grep -i \(nfs | awk '{ print $3 }'`
        herbe "[Local Server]" "${addr}" " " "[NFS Shares]" "${shares}"
    else
        herbe "[Local Server]" "connection closed."
    fi
}

while getopts "sm" o; do
    case $o in
        s) printStatus  ;;
        m) printMessage ;;
    esac
done
