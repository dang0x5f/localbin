#/bin/sh

# bestcompress -- Given a file, tries compressing it with all the available
#   compression tools and keeps the compressed file that's smallest,
#   reporting the result to the user. If -a isn't specified, bestcompress.sh
#   skips copmressed files in the input stream.

Z="compress"
Zout="/tmp/bestcompress.$$.Z"

gz="gzip"   
gzout="/tmp/bestcompress.$$.gz"

bz="bzip2"  
bzout="/tmp/bestcompress.$$.bz"

zip="zip"
zipout="/tmp/bestcompress.$$.zip"

skipcompressed=1

if [ "$1" = "-a" ]; then
    skipcompressed=0 ; shift
fi

if [ $# -eq 0 ]; then
    echo "Usage: $0 [-a] file or files to optimally compress" >&2
    exit 1
fi

trap "/bin/rm -f $Zout $gzout $bzout $zipout" EXIT

for name in "$@"
do
    if [ ! -f "$name" ]; then
        echo "$0: file $name not found. Skipped." >&2
        continue
    fi

    if [ "$(echo $name | egrep '(\.Z$|\.gz$|\.bz$|\.zip$)')" != "" ]; then
        if [ $skipcompressed -eq 1 ]; then
            echo "Skipped file ${name}: It's already compressed."
            continue
        else
            echo "Warning: Trying to double-compress $name"
        fi
    fi

    # Try compressing all three files in parallel.
    $Z   < "$name" > $Zout &
    $gz  < "$name" > $gzout &
    $bz  < "$name" > $bzout &
    $zip < "$name" > $zipout &

    wait # Wait until all copmressions are done.

    # Figure out which compressed best.
    smallest="$(ls -l "$name" $Zout $gzout $bzout $zipout | \
        awk '{print $5"="NR}' | sort -n | cut -d= -f2 | head -1)"

    case "$smallest" in
        1) echo "No space savings by compressing $name. Left as is." 
           ;;
        2) echo "Best compressiong is with compress. File renamed ${name}.Z"
           mv $Zout "${name}.Z" ; rm -f "$name"
           ;;
        3) echo "Best compressiong is with gzip. File renamed ${name}.gz"
           mv $gzout "${name}.gz" ; rm -f "$name"
           ;;
        4) echo "Best compressiong is with bzip2. File renamed ${name}.bz"
           mv $bzout "${name}.bz" ; rm -f "$name"
           ;;
        5) echo "Best compressiong is with zip. File renamed ${name}.zip"
           mv $zipout "${name}.zip" ; rm -f "$name"
           ;;
    esac
done

exit 0
