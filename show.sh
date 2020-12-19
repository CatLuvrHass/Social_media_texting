#!/bin/bash
if [ "$#" -ne 1 ]; then
	echo 'Error: parameters problem'>&2
	exit 1
fi

user="$1"
./P.sh "$user"
if [ ! -d "$user" ]; then
	echo "Error: user does not exist">&2
	./V.sh "$user"
	exit 2
else
	echo "wallStart"
	cat "$user/wall"
	echo "wallEnd"
./V.sh "$user"
fi
exit 0
