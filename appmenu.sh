#!/bin/sh

MENUWIDTH=200
# xdpyinfo works well on single monitor
#winWidth=`xdpyinfo | grep dimensions | awk '{print $2}' | cut -d x -f 1`
#winHeight=`xdpyinfo | grep dimensions | awk '{print $2}' | cut -d x -f 2`
winWidth=`xrandr | grep -i primary | awk '{print $4}' | cut -d+ -f1 | cut -dx -f1`
winHeight=`xrandr | grep -i primary | awk '{print $4}' | cut -d+ -f1 | cut -dx -f2`
posX=$(((${winWidth} / 2) - (${MENUWIDTH} / 2)))
posY=$(((${winHeight} / 2)))

set -euo pipefail

MainMenu() {
    printf "file management\n"
    # printf "development\n"
    printf "multimedia\n"
    printf "launcher\n"
    # printf "backup\n"
    # printf "games\n"
    printf "exit"
}

FmMenu() {
    printf "lf\n"
    printf "pcmanfm\n"
    printf "lxappearance\n"
    printf "exit"
}

DevMenu() {
    printf "???\n"
    printf "exit"
}

MediaMenu() {
    printf "gtkpod\n"
    printf "kid3\n"
    printf "???\n"
    printf "exit"
}

BackupMenu() {
    printf "???\n"
    printf "exit"
}

GamesMenu() {
    printf "wotlk335\n"
    printf "???\n"
    printf "exit"
}

UserInput() {
    printf "enter filename >> "
}

ExitPrompt() {
    exit 0
}

layerOne="$(MainMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 10)"

case $layerOne in
    "file management")      layerTwo="$(FmMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 4)" ;;
    # "development")          layerTwo="$(DevMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 5)" ;;
    "multimedia")           layerTwo="$(MediaMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 5)" ;;
    "launcher")             dmenu_run -x 0 -y 20 -w ${MENUWIDTH} -bw 3 -l 38 ;;
    # "backup")               layerTwo="$(BackupMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 10)" ;;
    # "games")                layerTwo="$(GamesMenu | dmenu -x ${posX} -y ${posY} -w ${MENUWIDTH} -bw 4 -l 5)" ;;
    *)                      ExitPrompt ;;
esac

case $layerTwo in
    "lf")                   st -e lf -single;;
    "pcmanfm")              pcmanfm ;;
    "lxappearance")         lxappearance ;;
    "gtkpod")               gtkpod ;;
    "kid3")                 kid3-qt ;;
    # "push dot files")       remote-backup.sh -l 1;;
    # "push code files")      remote-backup.sh -l 2;;
    # "push docs files")      remote-backup.sh -l 3;;
    # "push gtc files")       remote-backup.sh -l 4;;
    # "push scripts files")   remote-backup.sh -l 7;;
    # "wotlk335")             wine $HOME/.wine/drive_c/Program\ Files\ \(x86\)/Wow.exe ;;
    *)                      ExitPrompt ;;
esac
