#!/bin/sh

# plain text
printText() {
    herbe "Battery Life: `apm -l`"
    # echo " $(apm -l)"
}

# color
printColor() {
    bat=$(apm -l)

    if [ ${bat} -gt 90 ]; then
        echo "<fc=#fffdd0>"
    elif [ ${bat} -gt 80 ]; then
        echo "<fc=#eeeeee>"
    elif [ ${bat} -gt 70 ]; then
        echo "<fc=#dddddd>"
    elif [ ${bat} -gt 60 ]; then
        echo "<fc=#cccccc>"
    elif [ ${bat} -gt 50 ]; then
        echo "<fc=#bbbbbb>"
    elif [ ${bat} -gt 40 ]; then
        echo "<fc=#aaaaaa>"
    elif [ ${bat} -gt 30 ]; then
        echo "<fc=#999999>"
    elif [ ${bat} -gt 20 ]; then
        echo "<fc=#888888>"
    elif [ ${bat} -gt 10 ]; then
        echo "<fc=#777777>"
    else
        echo "<fc=#666666>"
    fi
}

while getopts "ct" o; do
    case $o in
        c) printColor ;;
        t) printText ;;
    esac
done
