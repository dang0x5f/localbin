#!/bin/sh -x

MUTE=0
VOL_UNIT=2

currentVol=$(mixer vol | cut -d: -f2)
currentMicVol=$(mixer mic | cut -d: -f2)
charCount=$(echo ${currentMicVol} | wc -c)

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

PrintVol() {
    herbe "Output Device Volume: ${currentVol}"
}

PrintCol()
{
    if [ ${currentVol} -gt 90 ]; then
        echo "<fc=#fffdd0>"
    elif [ ${currentVol} -gt 80 ]; then
        echo "<fc=#eeeeee>"
    elif [ ${currentVol} -gt 70 ]; then
        echo "<fc=#dddddd>"
    elif [ ${currentVol} -gt 60 ]; then
        echo "<fc=#cccccc>"
    elif [ ${currentVol} -gt 50 ]; then
        echo "<fc=#bbbbbb>"
    elif [ ${currentVol} -gt 40 ]; then
        echo "<fc=#aaaaaa>"
    elif [ ${currentVol} -gt 30 ]; then
        echo "<fc=#999999>"
    elif [ ${currentVol} -gt 20 ]; then
        echo "<fc=#888888>"
    elif [ ${currentVol} -gt 10 ]; then
        echo "<fc=#777777>"
    else
        echo "<fc=#666666>"
    fi

    # print num
    # echo " ${currentVol}"
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

PrintMicVol() {
    if [ ${charCount} -gt 5 ]; then
        herbe "Mic Volume: N/A" " " "Check microphone devices"
    else
        herbe "Mic Volume: ${currentMicVol}"
    fi
}

PrintMicCol()
{
    if [ ${charCount} -lt 5 ]; then
       # echo "${currentMicVol}"
       echo "<fc=#fffdd0>"
    else
        # echo "N/A"
        echo "<fc=#666666>"
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

while getopts "zudpPZUDmMtT" o; do
   case $o in
	z) MuteVol ;;
	u) IncrVol ;;
	d) DecrVol ;;
	p) PrintCol ;;
	P) PrintList ;;
	Z) MuteMic ;;
	m) PrintMicCol ;;
	M) PrintMicList ;;
    t) PrintMicVol ;;
    T) PrintVol ;;
   esac
done
