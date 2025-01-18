#!/bin/sh

cd $HOME/music

read -p "Enter URL >> " yturl

yt-dlp -x --audio-format "mp3" --embed-thumbnail --no-playlist $yturl
