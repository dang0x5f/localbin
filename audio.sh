#!/bin/sh -x

MUTE=0
VOL_UNIT=2

currentVol=$(mixer vol | cut -d: -f2)
currentMicVol=$(mixer mic | cut -d: -f2)

MuteVol()
{
   if [ $currentVol -gt 0 ]; then
	echo $currentVol > /tmp/vol.tmp
	mixer vol 0 && herbe "volume muted"
	exit 0
   else
	currentVol=$(cat /tmp/vol.tmp)
	mixer vol $currentVol && herbe "volume unmuted"
	exit 0
   fi
}

IncrVol()
{
   if [ $currentVol -le 98 ]; then
	currentVol=$(($currentVol + $VOL_UNIT))
	mixer vol $currentVol && herbe "volume: ${currentVol}"
   fi

   exit 0
}

DecrVol()
{
   if [ $currentVol -ge 2 ]; then
	currentVol=$(($currentVol - $VOL_UNIT))
	mixer vol $currentVol && herbe "volume: ${currentVol}"
   fi

   exit 0
}

PrintVol()
{
   echo " ${currentVol}"
}

PrintList()
{
    current="`virtual_oss_cmd /dev/dsp.ctl | tail -1 | cut -d' ' -f4`"
    choice="`cat /dev/sndstat | grep pcm | dmenu -p "Output:${current}" -l 5`"
    # smallest suffix
    choice=${choice%:*}
    # smallest prefix - check man sh -> substring
    choice=${choice#pcm*}

    virtual_oss_cmd /dev/dsp.ctl -O /dev/dsp${choice}
    # necessary for mixer controls
    sysctl hw.snd.default_unit=${choice}
}

MuteMic()
{
   if [ $currentMicVol -gt 0 ]; then
	echo $currentMicVol > /tmp/mic.tmp
	mixer mic 0 && herbe "mic muted"
	exit 0
   else
	currentMicVol=$(cat /tmp/mic.tmp)
	mixer mic $currentMicVol && herbe "mic unmuted"
	exit 0
   fi
}

PrintMicVol()
{
    if [ `echo ${currentMicVol} | wc -c` -lt 5 ]; then
       echo "${currentMicVol}"
    else
        echo "N/A"
    fi
}

PrintMicList()
{
    current="`virtual_oss_cmd /dev/dsp.ctl | tail -2 | head -1 | cut -d' ' -f4`"
    choice="`cat /dev/sndstat | grep pcm | dmenu -p "Input:${current}" -l 5`"
    # smallest suffix
    choice=${choice%:*}
    # smallest prefix - check man sh -> substring
    choice=${choice#pcm*}

    virtual_oss_cmd /dev/dsp.ctl -R /dev/dsp${choice}
    # necessary for mixer controls
    sysctl hw.snd.default_unit=${choice}
}

while getopts "zudpPZUDmM" o; do
   case $o in
	z) MuteVol ;;
	u) IncrVol ;;
	d) DecrVol ;;
	p) PrintVol ;;
	P) PrintList ;;
	Z) MuteMic ;;
	m) PrintMicVol ;;
	M) PrintMicList ;;
   esac
done
