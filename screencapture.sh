#!/bin/bash 

# uses image magick to take a screen shot
# xwininfo grabs the window id
# all the user has to do is click the window to screenshot

winID="-w $(xwininfo | grep "Window id" | awk '{print $4}')"

import ${winID} ~/Downloads/$(date "+%m-%d-%y_%H-%M-%S")_ScreenCap.png 
