#!/bin/bash

DIR="/mnt/iPhone_Images/*"
ROOT="/mnt/iPhone_Images/"

# HEIC
#for d in $DIR; do
#    if [ -d $d ]; then
#        for f in $d/*; do
#            if [ $(echo $f | cut -d. -f2) == "HEIC" ]; then
#                mv $f ${ROOT}heicDirectory
#            fi
#        done
#    fi
#done

# PNG
#for d in $DIR; do
#    if [ -d $d ]; then
#        for f in $d/*; do
#            if [ $(echo $f | cut -d. -f2) == "PNG" ]; then
#                mv $f ${ROOT}pngDirectory
#            fi
#        done
#    fi
#done

# JPG
#for d in $DIR; do
#    if [ -d $d ]; then
#        for f in $d/*; do
#            if [ $(echo $f | cut -d. -f2) == "JPG" ]; then
#                mv $f ${ROOT}jpgDirectory
#            fi
#        done
#    fi
#done


# MOV
#for d in $DIR; do
#    if [ -d $d ]; then
#        for f in $d/*; do
#            if [ $(echo $f | cut -d. -f2) == "MOV" ]; then
#                mv $f ${ROOT}movDirectory
#            fi
#        done
#    fi
#done


# AAE
for d in $DIR; do
    if [ -d $d ]; then
        for f in $d/*; do
            if [ $(echo $f | cut -d. -f2) == "AAE" ]; then
                mv $f ${ROOT}aaeDirectory
            fi
        done
    fi
done
