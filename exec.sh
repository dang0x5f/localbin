#!/bin/sh

usage(){
    echo "usage: ${0} lib proc"
}

if [ $# -ne 2 ]; then
    usage 
    exit
fi

case ${1} in
    "prt" ) . prtlib.sh   ;;
    "app" ) echo "app"   ;;
    "env" ) echo "env"   ;;
    "msg" ) . msglib.sh   ;;
    "util") echo "util"  ;;
      *   ) usage        ;;
esac

${2}
