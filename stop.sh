#!/bin/bash

# Stop and remove 3 instances of the docker container with the image plexinc/pms-docker
for i in {1..3}
do
    docker stop $(docker ps -a -q --filter="ancestor=plexinc/pms-docker")
    docker rm $(docker ps -a -q --filter="ancestor=plexinc/pms-docker")
done

# Stop and remove the dockers
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi

# Remove the network
docker network rm my_plex_network

