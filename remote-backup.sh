!/bin/sh

# date: 1.31.23

# FILES
dotSsh=".ssh/config"
dotMoc=".moc/themes 
        .moc/config 
        .moc/Keymap"
dotNews=".newsboat/config
         .newsboat/urls"
dotXMon=".xmonad/config.hs"
dotXMob=".config/xmobar/xmobarrc"
dotFiles=".shrc
          .vimrc
          .xinitrc
          .Xresources
          /usr/local/etc/xdg/picom.conf"

# VARS
sessionID=$$
sessionAction=""
kernel=$(uname -r)
hostUser=$(whoami)
log="/tmp/sync.txt"
dayInt="$(date "+%d")"
xmob="$(hostname)xmobarrc"
signOnMsg="***Starting Backup Sync***"
signOffMsg="***Backup Sync Terminated***"

# FUNCTIONS
writeToLog()
{
    hostMachine=$(hostname)
    currTime=$(date "+%m-%d-%y_%H:%M:%S")
    timeStamp="[${currTime}][@${hostMachine}][pid#${sessionID}]"

    ssh sayonara "echo ${timeStamp}: ${@} >> iolog"
}

syncAll()
{
}

pushConfig()
{
    cd


    if [ "$dayInt" -lt "8" ]; then
        rDir="bsd00/"
    elif [ "$dayInt" -lt "17" ]; then
        rDir="bsd01/"
    elif [ "$dayInt" -lt "25" ]; then
        rDir="bsd10/"
    elif [ "$dayInt" -ge "25" ]; then
        rDir="bsd11/"
    else
        herbe "Error:\nSyncConfig Block 1"
    fi
    
    ssh sayonara "/bin/mkdir ${rDir}dotSsh"
    ssh sayonara "/bin/mkdir ${rDir}dotMoc"
    ssh sayonara "/bin/mkdir ${rDir}dotConfig"
    ssh sayonara "/bin/mkdir ${rDir}dotXmonad"
    ssh sayonara "/bin/mkdir ${rDir}dotNewsboat"

    rsync -vr $dotFiles sayonara:${rDir} 2> ${log} 1> ${log}
    herbe "$(cat ${log})"
    rsync -vr $dotSsh sayonara:${rDir}dotSsh 2> ${log} 1> ${log}
    herbe "$(cat ${log})"
    rsync -vr $dotMoc sayonara:${rDir}dotMoc 2> ${log} 1> ${log}
    herbe "$(cat ${log})"
    rsync -vr $dotXMon sayonara:${rDir}dotXmonad 2> ${log} 1> ${log}
    herbe "$(cat ${log})"
    rsync -vr $dotNews sayonara:${rDir}dotNewsboat 2> ${log} 1> ${log}
    herbe "$(cat ${log})"
    rsync -vr $dotXMob sayonara:${rDir}dotConfig/$xmob 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed pushConfig Block"
}

pushCode()
{
    cd

    rsync -vr code/ sayonara:media/code/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed pushCode Block"
}

pushDocs()
{
    cd

    rsync -vr --delete-during docs/ sayonara:media/docs/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed pushDocs Block"
}

pushGTC()
{
    cd

    rsync -vr --delete gtc/ sayonara:school/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed pushGTC Block"
}

syncMusic()
{
    cd

    rsync -r music/ sayonara:media/music/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed SyncMusic Block"
}

syncPics()
{
    cd

    rsync -vr pics/ sayonara:media/pics/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed SyncPics Block"
}

pushScripts()
{
    cd

    rsync -vr --delete-during .local/bin/ sayonara:TheHolyScriptures/ 2> ${log} 1> ${log}
    herbe "$(cat ${log})"

    writeToLog "Executed SyncScripts Block"
}

syncVids()
{
}

displayHelp()
{
    echo " ? "
}

# START

trap "writeToLog $signOffMsg" 0 1 15

writeToLog $signOnMsg

while getopts "l:h" arg; do
    case "$arg" in
        l ) type="$OPTARG"; ;;
        h ) displayHelp     ;;
    esac
done

case "$type" in
    0 ) syncAll     ;;
    1 ) pushConfig  ;;
    2 ) pushCode    ;;
    3 ) pushDocs    ;;
    4 ) pushGTC     ;;
    5 ) syncMusic   ;;
    6 ) syncPics    ;;
    7 ) pushScripts ;;
    8 ) syncVids    ;;
    ? ) herbe "???" ;;
esac

# DEBUG
#pushGTC
#file $dotFileList
#file $dotDirList
