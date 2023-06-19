#!/bin/sh

menu() {
   ls ~/pdf/ | nl | awk '{print $NF}'
}

choice=$(menu | dmenu -p "Choose: " -l 10)

zathura $HOME/pdf/$choice
