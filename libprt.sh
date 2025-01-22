ssr_prt()
{
    file="/tmp/ssr-stats"
    if [ ! -f ${file} ]; then
        echo "<fc=#666666>"
        exit 0
    fi
    
    rec=$(grep recording ${file} | awk '{print $2}')
    case ${rec} in
        1) echo "<fc=#fffdd0>" ;;
        *) echo "<fc=#666666>" ;;
    esac
    exit 0
}

printer_prt()
{
    status="$(service lpd onestatus)"
    error_msg="lpd is not running."

    if [ "${status}" = "${error_msg}" ]; then
        echo "<fc=#666666>"
    else
        echo "<fc=#fffdd0>"
    fi
}

localserver_prt()
{
    server="cassiopeia"
    grepstr="1 packets transmitted, 1 packets received, 0.0% packet loss"
    status=$(ping -c 1 ${server} | grep -i "${grepstr}" | wc -l)

    case ${status} in
        0) echo "<fc=#666666>" ;;
        *) echo "<fc=#fffdd0>" ;;
    esac
}

internet_prt()
{
    # TODO status may be active 
    ifconfig | grep "status: associated" 1> /dev/null
    case $? in
        0) echo "<fc=#fffdd0>" ;;
        *) echo "<fc=#666666>" ;;
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

github_prt()
{
    ssh -T git@github.com
    case $? in
            1) fontcolor_prt 100 ;;
          255) fontcolor_prt   0 ;;
    esac
}

mic_prt()
{
    muteis=$(mixer -o rec.mute|cut -d= -f2)
    if [ ${muteis} == "on" ]; then
        fontcolor_prt 0
        return
    fi

    microphone=$(mixer -o rec.volume|cut -d: -f2)
    case ${microphone} in
        "1.00") fontcolor_prt 100
                ;;
        "0.00") fontcolor_prt 0
                ;;
           *  ) split=$(echo ${microphone}|cut -c 3-4)
                fontcolor_prt ${split}
                ;;
        esac
}

volume_prt()
{
    muteis=$(mixer -o vol.mute|cut -d= -f2)
    if [ ${muteis} == "on" ]; then
        fontcolor_prt 0      
        return
    fi

    volume=$(mixer -o vol.volume|cut -d: -f2)
    case ${volume} in
        "1.00") fontcolor_prt 100 
                ;;
        "0.00") fontcolor_prt 0      
                ;;
           *  ) split=$(echo ${volume}|cut -c 3-4) 
                fontcolor_prt ${split}
                ;;
    esac
}

battery_prt()
{
    pct=$(apm -l)
    if [ ${pct} -lt 50 ]; then
        charging=$(apm | grep "AC" | awk '{print $NF}')
        if [ ${charging} == "on-line" ]; then
            if   [ ${pct} -lt 10 ]; then
                echo "<fc=#00ff00,#666666> ${pct}% </fc> <fc=#666666>"
            elif [ ${pct} -lt 20 ]; then
                echo "<fc=#00ff00,#666666> ${pct}% </fc> <fc=#777777>"
            elif [ ${pct} -lt 30 ]; then
                echo "<fc=#00ff00,#666666> ${pct}% </fc> <fc=#888888>"
            elif [ ${pct} -lt 40 ]; then
                echo "<fc=#00ff00,#666666> ${pct}% </fc> <fc=#999999>"
            else
                echo "<fc=#00ff00,#666666> ${pct}% </fc> <fc=#aaaaaa>"
            fi
        else
            if   [ ${pct} -lt 10 ]; then
                echo "<fc=#e3735e,#666666> ${pct}% </fc> <fc=#666666>"
            elif [ ${pct} -lt 20 ]; then
                echo "<fc=#e3735e,#666666> ${pct}% </fc> <fc=#777777>"
            elif [ ${pct} -lt 30 ]; then
                echo "<fc=#f1fa8c,#666666> ${pct}% </fc> <fc=#888888>"
            elif [ ${pct} -lt 40 ]; then
                echo "<fc=#f1fa8c,#666666> ${pct}% </fc> <fc=#999999>"
            else
                echo "<fc=#f1fa8c,#666666> ${pct}% </fc> <fc=#aaaaaa>"
            fi
        fi
    else
        fontcolor_prt ${pct}
    fi
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
