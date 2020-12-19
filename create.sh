#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 'Error: parameteres problem'>&2
  exit 1
fi
user="$1"

./P.sh "$user"
if [ -d "$user" ]; then
  echo 'Error: user already exists'>&2
  ./V.sh "$user"
  exit 2
elif [ ! -d "$user" ]; then
  mkdir "$user" && touch "$user"/wall "$user"/friends
  echo 'OK: user created'
fi
./V.sh "$user"
exit 0
