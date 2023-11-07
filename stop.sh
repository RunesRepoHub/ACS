#!/bin/bash

# Stop and remove the dockers
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi

# Remove the network
docker network rm my_plex_network

