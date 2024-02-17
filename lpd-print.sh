#!/bin/sh

# Checks Line Printer Daemon (LPD) status
# Prints out available printers -- $ lpc status all

NOT_RUNNING="lpd is not running."

lpd_status=`service lpd onestatus`

printStatus() {
    if [ "${lpd_status}" = "${NOT_RUNNING}" ]; then
        echo "<fc=#666666>"
    else
        echo "<fc=#fffdd0>"
    fi
}

printMessage() {
    if [ "${lpd_status}" = "${NOT_RUNNING}" ]; then
        herbe "lpd is down." " " "onestart lpd using service cmd"
    else
        herbe "lpd printer list" " " "`lpc status all | grep -i : | sed 's/://g'`"
    fi
}

while getopts "sm" o; do
    case $o in
        s) printStatus  ;;
        m) printMessage ;;
    esac
done
