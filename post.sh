#!/bin/bash
sender="$2"
receiver="$1"
message="$3"


if [ "$#" -lt 3 ]; then
	echo 'Error: parameters problem'>&2
	exit 1
fi
if [ ! -d "$receiver" ]; then
	echo "Error: receiver does not exist">&2
	exit 2
elif [ ! -d "$sender" ]; then
	echo "Error: sender does not exist">&2
	exit 2
fi

./P.sh "$receiver"
if grep -Fxq "$sender" "$receiver/friends"; then
	echo "$sender: $message" >> "$receiver/wall"
	echo "Ok: message posted to wall"
./V.sh "$receiver"

else
	echo "Error: '$sender' is not a friend of '$receiver'">&2
	./V.sh "$receiver"
	exit 1
fi
#./V.sh "$reciever"
exit 0
