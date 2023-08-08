#!/bin/sh

setIconColor() {
    ssh -T git@github.com

    if [ $? -eq 255 ]; then
        echo "<fc=#666666>"
    elif [ $? -eq 1 ]; then
        echo "<fc=#fffdd0>"
    fi
}

printNotification() {
    ssh -T git@github.com

    if [ $? -eq 255 ]; then
        herbe "GitHub Not Connect" "Right click icon to open terminal and enter github key with ssh-add"
    elif [ $? -eq 1 ]; then
        herbe "GitHub Connected"
    fi
}

while getopts "ct" o; do
    case $o in
        c) setIconColor ;;
        t) printNotification ;;
    esac 
done
