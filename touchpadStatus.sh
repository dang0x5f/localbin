#!/bin/sh

isEnabled=$(sysctl hw.psm.elantech.touchpad_off | awk -F" " '{ printf $NF }')

if [ $isEnabled -eq 0 ]; then
	echo "<fc=#fffdd0>"
else
	echo "<fc=#666666>"
fi
