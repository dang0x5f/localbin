#!/bin/sh

# plain text notification
printText() {
    lite=$(backlight -q)
    herbe "Backlight Level: `backlight -q`"
}

# color
printColor() {
    lite=$(backlight -q)

    if [ $lite -gt 90 ]; then
        echo "<fc=#fffdd0>"
    elif [ $lite -gt 80 ]; then
        echo "<fc=#eeeeee>"
    elif [ $lite -gt 70 ]; then
        echo "<fc=#dddddd>"
    elif [ $lite -gt 60 ]; then
        echo "<fc=#cccccc>"
    elif [ $lite -gt 50 ]; then
        echo "<fc=#bbbbbb>"
    elif [ $lite -gt 40 ]; then
        echo "<fc=#aaaaaa>"
    elif [ $lite -gt 30 ]; then
        echo "<fc=#999999>"
    elif [ $lite -gt 20 ]; then
        echo "<fc=#888888>"
    elif [ $lite -gt 10 ]; then
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
