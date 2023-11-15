#!/bin/bash

#############
### TO-DO ###
#############
### Change source to new repo name
### source ~/Auto-YT-DL/Scripts/Core.sh

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "$YOUTUBE_DL_START"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker start $container_id
done
echo -e "$THIS_MAY_TAKE_A_WHILE"
echo -e "$YOUTUBE_DL_START_COMPLETED"

# Stop and remove the dockers
echo -e "$YOUTUBE_DL_STARTING_TEXT"
docker start plex jackett radarr sonarr tautulli deluge ombi
echo -e "$YOUTUBE_DL_STARTING_TEXT_COMPLETED"
