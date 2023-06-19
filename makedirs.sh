#!/bin/sh
# labeled, ordered dirs
# 05.19.23

# Checking parameters 
if [ $# -lt 3 ]; then
    echo -e "Not enough args\nsyntax: $0 name count"
elif [ $# -gt 3 ]; then
    echo -e "Too many args\nsyntax: $0 name count"
elif [ $3 -lt 2 ]; then
    echo -e "Stop being lazy\nsyntax: $0 name count"
fi

count=$2

while [ $count -le $3 ]; do
    if [ $count -lt 10 ]; then
        echo "Making directory: ${1}0${count}"
        mkdir ${1}0${count}
    else
        echo "Making directory: ${1}${count}"
        mkdir ${1}${count}
    fi
    count=$(($count + 1))
done
