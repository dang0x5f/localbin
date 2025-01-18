#!/bin/sh

media_path="$HOME/docs/books"

menu() {
   ls ${media_path} | nl | awk '{print $NF}'
}

choice=$(menu | dmenu -p "Choose: " -l 10)

zathura ${media_path}/$choice
