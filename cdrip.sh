#!/bin/bash

# paths
OLDPWD="${PWD}"
CDRIPDIR="${HOME}/.cdrip"

ConvertWavToMp3() {
    cd $CDRIPDIR

    if [ -f "track00.cdda.wav" ]; then
        rm -f track00.cdda.wav
    fi

    i=0
    for file in *; do
        if [ -f $file ]; then
            fileArray[i]=$file
            i=$((i + 1))
        fi
    done

    for file in "${fileArray[@]}"; do
        lame $file $file.mp3
    done

    cd $OLDPWD
}

NameNewMp3s() {
    cd $CDRIPDIR


    i=0
    for file in *.mp3; do
        if [ -f $file ]; then
            fileArray[i]=$file
            i=$((i + 1))
        fi
    done

    t=1
    for file in "${fileArray[@]}"; do
        if [ ${t} -lt 10 ]; then
            track="0${t}"
        else
            track="${t}"
        fi

        echo -e "\n(Prepended Track Number and Extension automatically added.)\n(NO spaces. Use underscores.)"
        read -p "Rename file '$file' >> " mp3
        mv ${file} ${track}-${mp3}.mp3
        echo "Renamed ${file} to ${track}-${mp3}.mp3"

        t=$((t + 1))
    done

    echo -e "\n(NO spaces. Use underscores.)"
    read -p "Name album directory >> " album
    mkdir $album
    mv *.mp3 $album
    echo -e "\nAll mp3s moved to ${CDRIPDIR}/${album}"
    mv ${album} ..

    rm -rf *.wav

    cd $OLDPWD
}

RipCd() {
    cd $CDRIPDIR

    cdparanoia -Bv

    cd $OLDPWD
}

while getopts "cnr" o; do
    case $o in
        c)  ConvertWavToMp3 ;;
        n)  NameNewMp3s ;;
        r)  RipCd ;;
    esac
done
