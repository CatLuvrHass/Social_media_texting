#!/bin/bash
#client.sh
#uses syntax ./client.sh $clientID $req [args]

clientID="$1"
request="$2"
user1="$3"
user2="$4"
message="$5"

#At least 2 paramaters
if [ "$#" -lt 2 ]; then
        echo "Error: paramaters problem in $0" >&2
        exit 1
#No more than 5 parameters
elif [ "$#" -gt 5 ]; then
	echo "Error: too many arguments given - if using post function, check that message is in quotation marks" >&2
	exit 1
#check that server has started
elif [ ! -e server.pipe ]; then
	echo "Error: server.pipe could not be found - check that server is running" >&2
	exit 1
else

#make pipe if not already present
#sleep 1 to avoid concurrency issues where pipe is not fully instantiated before output is sought
if [ ! -e "$clientID.pipe" ]; then
	mkfifo "$clientID.pipe"
	sleep 1
fi
	#check that valid requests are being input with case structure
        case "$request" in
		#error check that the correct number of arguments are being passed
                #also check for the existence of files where appropriate
                #protect server.pipe with semaphores in unlikely case that commands will get mangled
		create)
			if [ ! "$#" -eq 3 ]; then
				echo "Error: Parameters problem for create in $0" >&2
				exit 1
			else
				./P.sh server.pipe
				echo "$clientID" "$request" "$user1" >> server.pipe
				./V.sh server.pipe
				#process the output of the server
				cat "$clientID.pipe"
				exit 0
			fi
			;;
                add)
                        if [ ! "$#" -eq 4 ]; then
				echo "Error: Paramaters problem for add in $0" >&2
				exit 1
			elif [ ! -e "$user1" ]; then
				echo "Error: $user1 does not exist for add in $0" >&2
				exit 1
			elif [ ! -e "$user2" ]; then
				echo "Error: $user2 does not exist for add in $0" >&2
				exit 1
			else
				./P.sh server.pipe
				echo "$clientID" "$request" "$user1" "$user2" >> server.pipe
				./V.sh server.pipe
				#process the output of the server
				cat "$clientID.pipe"
				exit 0
			fi
			;;
                post)
                        if [ ! "$#" -eq 5 ]; then
                                echo "Error: Paramaters problem for post in $0" >&2
                                exit 1
                        elif [ ! -e "$user1" ]; then
                                echo "Error: $user1 does not exist for post in $0" >&2
                                exit 1
                        elif [ ! -e "$user2" ]; then
                                echo "Error: $user2 does not exist for post in $0" >&2
                                exit 1
			else
				./P.sh server.pipe
				echo "$clientID" "$request" "$user1" "$user2" "$message" >> server.pipe
				./V.sh server.pipe
				#process the output of the server
				cat "$clientID.pipe"
				exit 0
			fi
			;;
                show)
                        if [ ! "$#" -eq 3 ]; then
                                echo "Error: Paramaters problem for show in $0" >&2
                                exit 1
                        elif [ ! -e "$user1" ]; then
                                echo "Error: $user1 does not exist for show in $0" >&2
                                exit 1
                        else
				./P.sh server.pipe
				echo "$clientID" "$request" "$user1" >> server.pipe
				./V.sh server.pipe
				#process output of server
				head -n -1 "$clientID.pipe" | tail -n +2
				exit 0
			fi
                        ;;
                shutdown)
                        ./P.sh server.pipe
			echo "$clientID" "$request" >> server.pipe
			./V.sh server.pipe
			exit 0
                        ;;
                *)
                	echo "Error: bad request in $0" >&2
                	exit 1
			;;
        esac
fi
