# Credits
# I used https://www.geeksforgeeks.org/how-to-use-docker-for-gaming-servers-with-steamcmd/ as a reference for this dockerfile
# I modified it with information provided from the following sites:
# * https://www.survivalservers.com/wiki/index.php?title=How_to_Create_a_Palworld_Server_Guide
# * https://tech.palworldgame.com/dedicated-server-guide#linux
# * https://docs.docker.com/storage/volumes/
# * https://dev.to/izackv/running-a-docker-container-with-a-custom-non-root-user-syncing-host-and-container-permissions-26mb
# * https://docs.docker.com/engine/reference/commandline/image_build/
# * https://docs.docker.com/engine/reference/commandline/container_run/
# * https://docs.docker.com/engine/reference/run/
# * https://www.howtogeek.com/437958/how-to-use-the-chmod-command-on-linux/

# Command used to build:
# docker build --build-arg UID=1000 --build-arg GID=1000 -t palworld_server .

# Command used to run:
# docker run -p 8211:8211/udp -v vol_palworld:/home/game_files/palworld -d --name=palworld_server -e PORT=8211 -e PLAYERS=10 -e SERVER_NAME=MyServer palworld_server

# Using the latest ubuntu image
FROM ubuntu:latest
RUN apt update
ARG UID
ARG GID

# Setting /home as our working directory
WORKDIR /home

# Download and install all the necessary dependencies for steamcmd
RUN dpkg --add-architecture i386 \
 && apt-get update -y && apt install wget lib32gcc-s1 lib32stdc++6 \
 curl libstdc++6:i386 lib32z1 -y

# Install sudo, create a non-root user, and grant password-less sudo permissions
RUN apt install -y sudo && \
    addgroup --gid $GID nonroot && \
    adduser --uid $UID --gid $GID --disabled-password --gecos "" nonroot && \
    echo 'nonroot ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Presetting Values for liscence agreement keys using debconf-set-selections
RUN echo steam steam/question select "I AGREE" |  debconf-set-selections 
RUN echo steam steam/license note '' | debconf-set-selections 

# Installing SteamCMD  
RUN mkdir steamcmd && mkdir game_files && apt-get install -y --no-install-recommends steamcmd 

# Create a directory for our game files
RUN mkdir -p /home/game_files/palworld

# Create symlink for executable in /bin
RUN ln -s /usr/games/steamcmd /usr/bin/steamcmd 

RUN steamcmd +quit


# Copy our shell script to docker container.
# This shell script will be used to download gamefiles
# and configure our gameserver.
# Description for this file is given later

COPY download_and_run_gameserver.sh /home/entrypoint.sh

# Copy server configuration to container ( PalWorld specific )
COPY *.ini /home/game_files/palworld/Pal/Saved/Config/LinuxServer/

# Set executable permissions for our shell script
RUN chmod +x /home/entrypoint.sh

RUN chown -R nonroot:nonroot /home/game_files

# Set nonroot as the user for our container
USER nonroot

# Set our shell script as entrypoint for our container
# So that it gets executed when we RUN the container
ENTRYPOINT [ "/home/entrypoint.sh"]