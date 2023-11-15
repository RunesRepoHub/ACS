#!/bin/bash
# Stop and remove any docker with the image mikenye/youtube-dl

#############
### TO-DO ###
#############
### Change source to new repo name
### source ~/Auto-YT-DL/Scripts/Core.sh


echo -e "$YOUTUBE_DL_STOP"
echo -e "$THIS_MAY_TAKE_A_WHILE"

# Get the container IDs
container_ids=$(docker ps -q --filter ancestor=mikenye/youtube-dl)

# Send a stop command to all containers
for container_id in $container_ids; do
    docker stop $container_id
done