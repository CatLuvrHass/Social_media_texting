#!/bin/bash
#server.sh
#accepts clientID then create $user | add $user $friend | post $receiver $sender $message | show $user | shutdown

#instantiate the server pipe
mkfifo server.pipe

#server stays live until shutdown or bad request, in which case all pipes are removed from directory
while true; do
	#each argument, if present, is read in from pipe and designated its corresponding variable name
	read clientID request user1 user2 message < server.pipe
	#case structure to interact with base scripts
	# & is used to start processes in background
	case "$request" in
		create)
			./create.sh "$user1" &> "$clientID.pipe" &
			;;
		add)
			./add.sh "$user1" "$user2" &> "$clientID.pipe" &
			;;
		post)
			./post.sh "$user1" "$user2" "$message" &> "$clientID.pipe" &
			;;
		show)
			./show.sh "$user1" &> "$clientID.pipe" &
			;;
		shutdown)
			rm *.pipe
			exit 0
			;;
		*)
			echo "Error: bad request" >&2
			rm *.pipe
			exit 1
			;;
	esac
done
