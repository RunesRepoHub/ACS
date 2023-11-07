#!/bin/bash

# Stop and remove any docker with the image mikenye/youtube-dl
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
if [[ $container_count -gt 0 ]]; then
    docker stop $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}")
    docker rm $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}")
fi

# Stop and remove the dockers
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi

# Remove the network
docker network rm my_plex_network

