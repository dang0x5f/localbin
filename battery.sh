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
        if [ $(apm | grep "AC" | awk '{print $NF}') == "on-line" ]; then
            echo "<fc=#00ff00,#666666> ${bat}% </fc> <fc=#999999>"
        else
            echo "<fc=#f1fa8c,#666666> ${bat}% </fc> <fc=#999999>"
        fi
    elif [ ${bat} -gt 20 ]; then
        if [ $(apm | grep "AC" | awk '{print $NF}') == "on-line" ]; then
            echo "<fc=#00ff00,#666666> ${bat}% </fc> <fc=#888888>"
        else
            echo "<fc=#f1fa8c,#666666> ${bat}% </fc> <fc=#888888>"
        fi
    elif [ ${bat} -gt 10 ]; then
        if [ $(apm | grep "AC" | awk '{print $NF}') == "on-line" ]; then
            echo "<fc=#00ff00,#666666> ${bat}% </fc> <fc=#777777>"
        else
            echo "<fc=#e3735e,#666666> ${bat}% </fc> <fc=#777777>"
        fi
    else
        if [ $(apm | grep "AC" | awk '{print $NF}') == "on-line" ]; then
            echo "<fc=#00ff00,#666666> ${bat}% </fc> <fc=#666666>"
        else
            echo "<fc=#e3735e,#666666> ${bat}% </fc> <fc=#666666>"
        fi
    fi
}

while getopts "ct" o; do
    case $o in
        c) printColor ;;
        t) printText ;;
    esac
done
