#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "$YOUTUBE_DL_STOP"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker stop $container_id
done
echo -e "$THIS_MAY_TAKE_A_WHILE"


# Stop and remove the dockers
echo -e "$YOUTUBE_DL_STOPPING_TEXT"
docker stop plex jackett radarr sonarr tautulli deluge ombi
echo -e "$YOUTUBE_DL_STOP_COMPLETED"
