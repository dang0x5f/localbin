#!/bin/sh

usage(){
    echo "usage: ${0} lib proc [param ...]"
}

if [ $# -lt 2 ]; then
    usage 
    exit 1
fi

case ${1} in
    "env" ) echo "env"   ;;
    "msg" ) . libmsg.sh   ;;
    "prt" ) . libprt.sh   ;;
    "util") . libutil.sh  ;;
      *   ) usage         ;;
esac

case $# in
    2 ) ${2}           ;;
    3 ) ${2} ${3}      ;;
    4 ) ${2} ${3} ${4} ;;
    * ) usage          ;;
esac

exit 0
