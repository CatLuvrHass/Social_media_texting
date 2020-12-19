#!/bin/bash

id="$1"
req="$2"
user="$3"
friend="$4"
message="$5"

if [ "$#" -lt 2 ]; then
echo "Error: parameters problem">&2
exit 1
fi

clientpipe="/home/cs15436488/git_repos/project-CatLuvrHass/$id.pipe"

mkfifo $clientpipe
serverpipe="/home/cs15436488/git_repos/project-CatLuvrHass/server.pipe"


if [[ "$req" -eq create ]]; then
	echo "$id $req $user $friend $message">$serverpipe

elif [[ "$req" -eq add ]]; then
	echo "$id $req $user $friend $message">$serverpipe

elif [[ "$req" -eq post ]]; then
	echo "$id $req $user $friend $message">$serverpipe

elif [[ "$req" -eq show ]]; then
	echo "$id $req $user $friend $message">$serverpipe

elif [[ "$req" -eq shutdown ]]; then
	echo "$id $req">$serverpipe
fi

#read output from serverpipe
while read output; do
	echo "$output"
done<$clientpipe

rm $clientpipe
