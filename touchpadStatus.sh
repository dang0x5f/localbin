#!/bin/sh

isEnabled=$(sysctl hw.psm.elantech.touchpad_off | awk -F" " '{ printf $NF }')

if [ $isEnabled -eq 0 ]; then
	echo " on"
else
	echo " off"
fi
