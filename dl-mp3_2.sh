#!/bin/sh

cd ~/Downloads

read -p "URL >> " yturl

#export yturl

youtube-dl -x --audio-format "mp3" $yturl
