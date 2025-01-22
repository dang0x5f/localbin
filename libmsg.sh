printer_msg()
{
    # TODO split to separate application
    status=$(service lpd onestatus)
    error_msg="lpd is not running."

    if [ "${status}" = "${error_msg}" ]; then
        herbe "lpd is down."                \
              " "                           \
              "onestart lpd using service cmd"
    else
        herbe "lpd printer list."           \
              " "                           \
              "`lpc status all | grep -i : | sed 's/://g'`"
    fi
}

localserver_msg()
{
    # TODO
    herbe "todo"
}

internet_msg()
{
    # TODO
    herbe "todo"
}

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

mic_msg()
{
    muteis=$(mixer -o rec.mute|cut -d= -f2)
    microphone=$(mixer -o rec.volume|cut -d: -f2)

    if [ ${muteis} == "on" ]; then
        herbe "microphone : ${microphone}% (muted)"
        return
    fi

    herbe "microphone : ${microphone}%"
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

battery_msg()
{
    pct=$(apm -l)
    herbe "battery life : ${pct}%"
}

backlight_msg()
{
    pct=$(backlight -q)
    herbe "backlight level : ${pct}%"
}
