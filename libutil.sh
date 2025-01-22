wincopy()
{
    # imagemagick
    path="~/Downloads/"
    date=$(date "+%m%d%y%H%M%S")
    winid="-w $(xwininfo|grep "Window id"|awk '{print $4}')"
    import ${winid} ${path}${date}_cap.png
}

mic_up()
{
    microphone=$(mixer -o rec.volume | cut -d: -f2)
    case ${microphone} in
        "1.00") break
                ;;
           *  ) mixer rec.volume=+3%
                ;;
    esac
    . libmsg.sh && mic_msg
}

mic_down()
{
    microphone=$(mixer -o rec.volume | cut -d: -f2)
    case ${microphone} in
        "0.00") break
                ;;
           *  ) mixer rec.volume=-3%
                ;;
    esac
    . libmsg.sh && mic_msg
}

mic_mute()
{
    mixer rec.mute=toggle
    . libmsg.sh && mic_msg
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
    . libmsg.sh && volume_msg
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
    . libmsg.sh && volume_msg
}

volume_mute()
{
    mixer vol.mute=toggle
    . libmsg.sh && volume_msg
}
