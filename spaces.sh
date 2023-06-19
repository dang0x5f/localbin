#!/bin/sh

# Removes spaces in file names

count=0

# Error on no args

if [ $# -eq 0 ]; then
	echo "Usage: $(basename $0) filename[ or entire dir w/ wildcard globbing]"
	echo "Please enter argument"
	exit 1
fi

# Loops args while they exist

while [ $# -gt 0 ]; do
	if [ -f "$1" ]; then				# Is it an existing file
		nospace="$(echo $1 | sed 's/ /_/g')"	# Replace spaces
		mv "$1" $nospace			# Rename file
		echo "Renamed file $1 to $nospace"
	else
		echo "Not a file."		# Not a file
		count=$(( $count + 1 ))
	fi
	shift
done

echo "Total non files parsed: $count"

exit 0
