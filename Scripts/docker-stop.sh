#!/bin/bash
# 
# Stop and remove any docker with the image mikenye/youtube-dl
source ~/YT-Plex/Scripts/Core.sh

echo -e "$YOUTUBE_DL_STOP"
echo -e "$THIS_MAY_TAKE_A_WHILE"

# Get the container IDs
container_ids=$(docker ps -q --filter ancestor=mikenye/youtube-dl)

# Send a stop command to all containers
for container_id in $container_ids; do
    docker stop $container_id
done