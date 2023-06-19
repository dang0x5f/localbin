#!/bin/bash

cd $HOME/music

read -p "Enter URL >> " yturl

export yturl

python3 /usr/local/bin/youtube-dl -x --audio-format "mp3" --embed-thumbnail $yturl
