#!/bin/bash
if [ "$#" -ne 2 ]; then
  	echo 'Error: parameters problem'>&2
	exit 1
fi
user="$1"
friend="$2"

if [ ! -d "$user" ]; then
	echo 'Error: user does not exist'>&2
	exit 2
elif [ ! -d "$friend" ]; then
	echo 'Error: friend does not exist'>&2
	exit 2
fi

./P.sh "$user"
if grep -Fxq "$friend" "$user/friends"; then
	echo "Error: user already friends with this user">&2
	./V.sh "$user"
	exit 1
else
	echo "$friend" >> "$user/friends"
	echo "Ok: friend added"

fi
./V.sh "$user"
exit 0
