#!/bin/bash

serverpipe="/home/cs15436488/git_repos/project-CatLuvrHass/server.pipe"
mkfifo $serverpipe

while true;
do

read -a request < $serverpipe

clientpipe="/home/cs15436488/git_repos/project-CatLuvrHass/${request[0]}.pipe"

case "${request[1]}" in

create)
./create.sh "${request[2]}" &> $clientpipe ;;
add)
./add.sh "${request[2]}" "${request[3]}" &> $clientpipe ;;

post)
./post.sh "${request[2]}" "${request[3]}" "$(echo ${request[@]:4})" &> $clientpipe ;;

show)
./show.sh "${request[2]}" &> $clientpipe ;;

shutdown)
echo "shutting" &> $clientpipe
rm $serverpipe
exit 0 ;;
*)
echo 'Error: bad request'
rm $serverpipe
exit 1;;
esac
done
rm $serverpipe
