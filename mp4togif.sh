#!/bin/sh

# google ffmpeg mp4 -> gif
# example
# ffmpeg -i noise.mp4 -r 15 -vf "scale=2*1408:-1, crop=1408/2:792/2" noise.gif
# scale, or factor, mult by the with can be changed

ffmpeg -i $1 -r 15 -vf "scale=3*$3:-1, crop=$3/2:$4/2" $2.gif
