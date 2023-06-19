#!/bin/sh

set -euo pipefail

DisplayMenu()
{
   printf "exit\n"
   printf "reboot\n"
   printf "shutdown"
}

RunReboot() 
{
   shutdown -r now
}

RunShutdown()
{
   shutdown -p now
}

ExitPrompt()
{
    exit 0
}

decision="$(DisplayMenu | dmenu -x 0 -y 18 -w 100 -bw 3 -l 3)"

case $decision in
	"reboot")	RunReboot ;;
	"shutdown")	RunShutdown ;;
	*)		ExitPrompt ;;
esac
