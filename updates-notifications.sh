#!/bin/sh

index=0
delim="~"
file="/tmp/update-notifications.tmp"

pkg upgrade -n | grep "packages to be upgraded:" 1> /dev/null 2> /dev/null
if [ $? -eq 1 ]; then
    output_string="Packages are up to date."
else
    upgrades=`pkg upgrade -n | grep "packages to be upgraded:" | awk '{print $NF}'`
    sizeofup=`pkg upgrade -n | grep "downloaded." | awk '{print $1 " " $2}'`

    output_string="Package upgrades: ${upgrades} (${sizeofup})"
fi

write_stdout(){
    echo "${output_string}"
}
write_file(){
    echo "${index}${delim}${output_string}" > ${file}
}


while getopts "wp" o; do
    case $o in
      p) write_stdout ;;
      w) write_file   ;;
    esac
done
