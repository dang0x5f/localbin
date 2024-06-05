#!/bin/sh

isEnabled=$(sysctl hw.psm.elantech.touchpad_off | awk -F" " '{ printf $NF }')

toggle_touchpad(){
    if [ ${isEnabled} -eq 0 ]; then
        sysctl hw.psm.elantech.touchpad_off=1
    else
        sysctl hw.psm.elantech.touchpad_off=0
    fi
}

status_touchpad(){
    if [ ${isEnabled} -eq 0 ]; then
        echo "<fc=#fffdd0>"
    else
        echo "<fc=#666666>"
    fi
}

while getopts "ts" o; do
    case $o in
        t)  toggle_touchpad ;;        
        s)  status_touchpad ;;
    esac
done
