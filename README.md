A dockerized version of the steam dedicated palworld server.

Use `docker run -p 8211:8211/udp -v vol_palworld:/home/game_files/palworld -d --name=palworld_server -e PORT=8211 -e PLAYERS=10 -e SERVER_NAME=MyServer palworld_server` to run the server.
You can change the parameters to whatever you like.

After setting up the server using docker, you can customize the config file.
In `game_server/Dockerfile` you can some resources I used to make this container. This also includes some documentation on serversettings.

Currently, there is a bug that doesn't allow you to use a password with an IP based server. the dev's are on it. You can either not use a password, or set the server as a community server.
The latter is currently not supported by this docker container. I will update this in the future.
