#!/bin/sh

cd $HOME/music

read -p "Enter URL >> " yturl

youtube-dl -x --audio-format "mp3" --embed-thumbnail --no-playlist $yturl
