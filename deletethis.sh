#!/bin/bash

l=1
for script in *; do
    if [ ${l} -lt 10 ]; then
        track="0${l}"
    else
        track="${l}"
    fi

    file="${track}-${script}"
    echo ${file}

    l=$((l + 1))
done
