#!/bin/sh

# string , index > file
mocp --info 1> /dev/null 2> /dev/null
if [ $? != 0 ]; then
    # echo ". . . . . . . . . . . . "
    echo " ...Nothing Loaded...   "
    exit 0
fi

title="$( mocp --info 2> /dev/null | grep SongTitle | cut -d' ' -f2-)"
artist="$(mocp --info 2> /dev/null | grep Artist    | cut -d' ' -f2-)"
state=$( mocp --info 2> /dev/null | grep State     | cut -d' ' -f2 )
songtitle=" ${title} - ${artist} "
index=0
delim="~"
file="/tmp/mocp-ticker.tmp"
binary="${HOME}/.local/bin/ticker"

if [ ! -e ${file} ]; then
    echo "${index}${delim}${songtitle}" > ${file}
    ${binary} "${songtitle}" "${file}"
else
    # echo ${songtitle}
    if [ ${state} == "PLAY" -o ${state} == "PAUSE" ]; then
        ${binary} "${songtitle}" "${file}"
    elif [ ${state} == "STOP" ]; then
        # echo " ...Playlist Ended...   "
        echo " ...Nothing Loaded...   "
    fi 
fi
