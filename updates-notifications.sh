#!/bin/sh

index=0
delim="~"
file="/tmp/updates-script.tmp"

pkg upgrade -n | egrep "packages to be upgraded:" 1> /dev/null 2> /dev/null
if [ $? -eq 1 ]; then
    output_string="Packages are up to date."
else
    upgrades=`pkg upgrade -n | egrep "packages to be upgraded:" | awk '{print $NF}'`
    sizeofup=`pkg upgrade -n | egrep "downloaded." | awk '{print $1 " " $2}'`

    output_string="${upgrades} upgrades (${sizeofup})"
fi

mobo=`sysctl hw.acpi.thermal.tz0.temperature | cut -d' ' -f2`
cpu3=`sysctl dev.cpu.3.temperature | cut -d' ' -f2`
cpu2=`sysctl dev.cpu.2.temperature | cut -d' ' -f2`
cpu1=`sysctl dev.cpu.1.temperature | cut -d' ' -f2`
cpu0=`sysctl dev.cpu.0.temperature | cut -d' ' -f2`

output_string="${output_string} | tz0 ${mobo} | cpu3 ${cpu3} cpu2 ${cpu2} cpu1 ${cpu1} cpu0 ${cpu0} "

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
