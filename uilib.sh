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
