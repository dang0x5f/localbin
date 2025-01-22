makegif()
{
    # new solution
    # https://superuser.com/questions/556029/how-do-i-convert-a-video-to-gif-using-ffmpeg-with-reasonable-quality
    # smol
    # ffmpeg -i $1 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
    # largo
    ffmpeg -i ${1} -vf "fps=10,scale=1024:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 ${2}
}

wow()
{
    winepath=${HOME}"/.wine/WoW-MOP/drive_c/Program Files/"
    mop='MOP-5.4.8.18414/'
    wotlk='WorldOfWarcraft3.3.5a/'

    case ${1} in
        "mop"  ) cd "${winepath}${mop}"   ;;
        "wotlk") cd "${winepath}${wotlk}" ;;
           *   ) exit 1                   ;;
    esac

    wine Wow.exe 2> /dev/null & && echo "starting..."
    exit 0
}

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
