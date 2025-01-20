localserver_msg()
{
    # TODO
}

internet_msg()
{
    # TODO
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

volume_up()
{
    volume=$(mixer -o vol.volume | cut -d: -f2)
    case ${volume} in
        "1.00") break
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

backlight_msg()
{
    pct=$(backlight -q)
    herbe "backlight level : ${pct}%"
}
