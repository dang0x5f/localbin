#!/bin/sh

# plain text
printText() {
    herbe "Battery Life: `apm -l`"
    # echo " $(apm -l)"
}

# color
printColor() {
    bat=$(apm -l)

    if [ $bat -gt 75 ]; then
        echo "<fc=#fffdd0>"
    elif [ $bat -gt 50 ]; then
        echo "<fc=#cccccc>"
    elif [ $bat -gt 25 ]; then
        echo "<fc=#999999>"
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
