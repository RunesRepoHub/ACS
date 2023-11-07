#!/bin/bash

# Stop and remove any docker with the image plexinc/pms-docker
docker stop $(docker ps -a -q --filter="mikenye/youtube-dl")
docker rm $(docker ps -a -q --filter="mikenye/youtube-dl")

# Stop and remove the dockers
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi

# Remove the network
docker network rm my_plex_network

