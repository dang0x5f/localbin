#!/bin/sh
updatefile="/tmp/updates-script.tmp"
binary="${HOME}/.local/bin/ticker"
delim="~"
len=20

# string , index > file
mocp --info 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
    # echo ". . . . . . . . . . . . "
    # echo " ...Nothing Loaded...   "
    str="$(cat /tmp/updates-script.tmp | cut -d~ -f2)"
    ${binary} "${str}" "${updatefile}" ${len}
    exit 0
fi

title="$( mocp --info 2> /dev/null | grep SongTitle | cut -d' ' -f2-)"
artist="$(mocp --info 2> /dev/null | grep Artist    | cut -d' ' -f2-)"
state=$(  mocp --info 2> /dev/null | grep State     | cut -d' ' -f2 )
songtitle=" ${title} - ${artist} "
index=0
mocpfile="/tmp/mocp-ticker.tmp"

if [ ! -e ${mocpfile} ]; then
    echo "${index}${delim}${songtitle}" > ${mocpfile}
    ${binary} "${songtitle}" "${mocpfile}" ${len}
else
    # echo ${songtitle}
    if [ ${state} == "PLAY" -o ${state} == "PAUSE" ]; then
        ${binary} "${songtitle}" "${mocpfile}" ${len}
    elif [ ${state} == "STOP" ]; then
        str="$(cat /tmp/updates-script.tmp | cut -d~ -f2)"
        ${binary} "${str}" "${updatefile}" ${len}
    fi 
fi
