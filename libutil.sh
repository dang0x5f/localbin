. libmsg.sh

mic_up()
{
    microphone=$(mixer -o mic.volume | cut -d: -f2)
    case ${microphone} in
        "1.00") break
                ;;
           *  ) mixer rec.volume=+3%
                ;;
    esac
    mic_msg
}

mic_down()
{
    microphone=$(mixer -o mic.volume | cut -d: -f2)
    case ${microphone} in
        "0.00") break
                ;;
           *  ) mixer rec.volume=-3%
                ;;
    esac
    mic_msg
}

mic_mute()
{
    mixer vol.mute=toggle
    mic_msg
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
