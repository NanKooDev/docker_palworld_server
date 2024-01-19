#!/bin/bash

# Download game files using SteamCMD to the specified volume
# The volume needs to be mounted when running the container

# Run SteamCMD to download the game files using app ID - 2394010 ( Palworld server )
steamcmd +force_install_dir /home/game_files/palworld +login anonymous +app_update 2394010 validate +quit

# Start the game server using the downloaded game files
cd game_files/palworld


# Finally start the game server, with ServerName, port and players from environment variable
./PalServer.sh -ServerName=$SERVER_NAME -port=$PORT -players=$PLAYERS -log -nosteam