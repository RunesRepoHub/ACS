#!/bin/bash

#############
### TO-DO ###
#############
### Change source to new repo name
### source ~/Auto-YT-DL/Scripts/Core.sh

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "$YOUTUBE_DL_STOP_REMOVE_TEXT"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker stop $container_id
done
echo -e "$YOUTUBE_DL_STOP_REMOVE_COMPLETED"


# Stop and remove the dockers
echo -e "$DOCKER_STOP_REMOVE_TEXT"
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi
echo -e "$DOCKER_STOP_REMOVE_COMPLETED"


# Remove the network
echo -e "$DOCKER_NETWORK_STOP_REMOVE"
docker network rm my_plex_network
echo -e "$DOCKER_NETWORK_STOP_REMOVE_COMPLETED"
