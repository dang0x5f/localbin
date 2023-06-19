#!/bin/sh -x
# evtest below device
# xinput --list -> xinput --disable $rfidscanner
# /etc/crontab entry: @reboot root:wheel /home/$USER/.local/bin/rfid.sh &

device='/dev/input/event6'
#event_newline='*code 28 (KEY_ENTER), value 1*'
event_num0='*code 11 (KEY_0), value 1*'
event_num1='*code 2 (KEY_1), value 1*'
event_num2='*code 3 (KEY_2), value 1*'
event_num3='*code 4 (KEY_3), value 1*'
event_num4='*code 5 (KEY_4), value 1*'
event_num5='*code 6 (KEY_5), value 1*'
event_num6='*code 7 (KEY_6), value 1*'
event_num7='*code 8 (KEY_7), value 1*'
event_num8='*code 9 (KEY_8), value 1*'
event_num9='*code 10 (KEY_9), value 1*'

evtest "$device" | while read line; do
    case $line in
        #($event_newline) echo -e "";;
        ($event_num0) code=${code}0;;
        ($event_num1) code=${code}1;;
        ($event_num2) code=${code}2;;
        ($event_num3) code=${code}3;;
        ($event_num4) code=${code}4;;
        ($event_num5) code=${code}5;;
        ($event_num6) code=${code}6;;
        ($event_num7) code=${code}7;;
        ($event_num8) code=${code}8;;
        ($event_num9) code=${code}9;;
    esac
    
    if [ `echo $code | wc -c` -eq 11 ]; then
        echo $code > /tmp/rfid.tmp
        su -l dang -c 'env DISPLAY=:0 /usr/local/bin/herbe `cat /tmp/rfid.tmp` '
        case $code in
            0007939453) su -l $USER -c 'env DISPLAY=:0 PATH="$PATH:$HOME/.local/bin" remote-backup.sh -l 2' ;;
            #0007939453) su -l $USER -c 'env DISPLAY=:0 /usr/local/bin/herbe "code scanned"' ;;
        esac
        code=""
    fi
done
