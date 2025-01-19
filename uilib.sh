touchpad_toggle()
{
    status=$(sysctl hw.psm.elantech.touchpad_off \
           | awk -F" " '{printf $NF}')
    
    case ${status} in
        0) sysctl hw.psm.elantech.touchpad_off=1
           herbe "touchpad off"
           ;;
        *) sysctl hw.psm.elantech.touchpad_off=0
           herbe "touchpad on"
           ;;
    esac
}

touchpad_prt()
{
    status=$(sysctl hw.psm.elantech.touchpad_off \
           | awk -F" " '{printf $NF}')

    case ${status} in
        0) fontcolor_prt 100 ;;
        *) fontcolor_prt   0 ;;
    esac
}

github_msg()
{
    ssh -T git@github.com
    case $? in
          1) herbe "GitHub Connected"
             ;;
        255) herbe "GitHub Disconnected"       \
                   " "                         \
                   "Right click icon to open"  \
                   "terminal and enter github" \
                   "using ssh-add"
             ;;
    esac
}

github_prt()
{
    ssh -T git@github.com
    case $? in
            1) fontcolor_prt 100 ;;
          255) fontcolor_prt   0 ;;
    esac
}

volume_msg()
{
    muteis=$(mixer -o vol.mute|cut -d= -f2)
    volume=$(mixer -o vol.volume | cut -d: -f2)

    if [ ${muteis} == "on" ]; then
        herbe "volume : ${volume}% (muted)"
        return
    fi

    herbe "volume : ${volume}%"
}

volume_prt()
{
    muteis=$(mixer -o vol.mute|cut -d= -f2)
    if [ ${muteis} == "on" ]; then
        fontcolor_prt 0      
        return
    fi

    volume=$(mixer -o vol.volume | cut -d: -f2)
    case ${volume} in
        "1.00") fontcolor_prt 100 
                ;;
        "0.00") fontcolor_prt 0      
                ;;
           *  ) split=$(echo ${volume} | cut -c 3-4) 
                fontcolor_prt ${split}
                ;;
    esac
}

volume_up()
{
    volume=$(mixer -o vol.volume | cut -d: -f2)
    case ${volume} in
        "1.00") break
                ;;
        "0.00") break
                ;;
           *  ) mixer vol.volume=+3%
                ;;
    esac
    volume_msg
}

volume_down()
{
    volume=$(mixer -o vol.volume | cut -d: -f2)
    case ${volume} in
        "1.00") break
                ;;
        "0.00") break
                ;;
           *  ) mixer vol.volume=-3%
                ;;
    esac
    volume_msg
}

volume_mute()
{
    mixer vol.mute=toggle
    volume_msg
}

battery_msg()
{
    pct=$(apm -l)
    herbe "battery life : ${pct}%"
}

battery_prt()
{
    pct=$(apm -l)
    fontcolor_prt ${pct}
}

backlight_msg()
{
    pct=$(backlight -q)
    herbe "backlight level : ${pct}%"
}

backlight_prt()
{
    pct=$(backlight -q)
    fontcolor_prt ${pct}
}

fontcolor_prt()
{

    if   [ ${1} -gt 90 ]; then
        echo "<fc=#fffdd0>"
    elif [ ${1} -gt 80 ]; then
        echo "<fc=#eeeeee>"
    elif [ ${1} -gt 70 ]; then
        echo "<fc=#dddddd>"
    elif [ ${1} -gt 60 ]; then
        echo "<fc=#cccccc>"
    elif [ ${1} -gt 50 ]; then
        echo "<fc=#bbbbbb>"
    elif [ ${1} -gt 40 ]; then
        echo "<fc=#aaaaaa>"
    elif [ ${1} -gt 30 ]; then
        echo "<fc=#999999>"
    elif [ ${1} -gt 20 ]; then
        echo "<fc=#888888>"
    elif [ ${1} -gt 10 ]; then
        echo "<fc=#777777>"
    else
        echo "<fc=#666666>"
    fi

}
