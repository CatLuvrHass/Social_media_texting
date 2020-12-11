#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo 'Error: parameteres problem'>&2
  exit 1
fi
user="$1"
if [ -d "$user" ]; then
  echo 'Error: user already exists'>&2
  exit 2
elif [ ! -d "$user" ]; then
  mkdir "$user" && touch "$user"/wall "$user"/friends
  echo 'OK: user created'
  exit 0
fi
