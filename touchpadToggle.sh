#!/bin/sh

isEnabled=$(sysctl hw.psm.elantech.touchpad_off | awk -F" " '{ printf $NF }')

if [ $isEnabled -eq 0 ]; then
	sysctl hw.psm.elantech.touchpad_off=1
else
	sysctl hw.psm.elantech.touchpad_off=0
fi
