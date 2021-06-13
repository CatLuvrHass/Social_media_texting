# Social_media_texting
Bash scripts for a social media network. A server and clients that can add eachother, message eachother and view the message walls.
Using P.sh and V.sh to deal with concurrency issues such as context switching or two clients making a request at the same time.
### to use:
1. clone repository 
2. open 2 terminal windows. 
3. run bash server.sh or ./server.sh in one terminal. this will have the server create a server.pipe and wait for instructions from user.
4. In the second terminal input as follows: ./client.sh $clientID $request [args].
5. the arguments range from 1)create - creates a user 2)add - adds one user to anothers friend list 3)post - post a message from one user to another 4)show - shows a user's wall 5)shutdown - terminates the session with the server and deletes the pipe.
