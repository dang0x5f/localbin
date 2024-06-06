#!/bin/sh

# usage:
#   mp4togif.sh old.mp4 new.gif
 
# old solution
# ffmpeg -i noise.mp4 -r 15 -vf "scale=2*1408:-1, crop=1408/2:792/2" noise.gif
# scale, or factor, mult by the with can be changed
# ffmpeg -i $1 -r 15 -vf "scale=3*$3:-1, crop=$3/2:$4/2" $2.gif


# new solution
# https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
ffmpeg -i $1 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
