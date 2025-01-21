#!/bin/sh

usage(){
    echo "usage: ${0} lib proc"
}

if [ $# -ne 2 ]; then
    usage 
    exit
fi

case ${1} in
    "app" ) echo "app"   ;;
    "env" ) echo "env"   ;;
    "msg" ) . libmsg.sh   ;;
    "prt" ) . libprt.sh   ;;
    "util") . libutil.sh  ;;
      *   ) usage         ;;
esac

${2}
