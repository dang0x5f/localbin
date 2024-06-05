#!/bin/sh

LOCKFILE="/tmp/swixm.lockfile"

printStatus(){
    if [ -f ${LOCKFILE} ]; then
        echo "<fc=#8be9fd,#666666> `cut -d, -f2 ${LOCKFILE}` </fc> <fc=#fffdd0>"
    else
        echo "<fc=#666666>"
    fi
}

killTimer(){
    if [ -f ${LOCKFILE} ]; then
        pid=`cut -d, -f1 ${LOCKFILE}`
        kill ${pid}
    fi
}

notifyFail(){
    herbe "POMODORO" " " "Timer already running!"
}

while getopts "pkn" o; do
    case $o in
        p) printStatus ;;
        k) killTimer ;;
        n) notifyFail ;;
    esac
done
