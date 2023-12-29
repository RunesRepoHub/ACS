#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "${Red}Stopping any and all mikenye/youtube-dl dockers then delete them${NC}"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker stop $container_id
done
echo -e "${Green}All mikenye/youtube-dl dockers have been stopped and removed${NC}"


# Stop and remove the dockers
echo -e "${Red}Stopping and removing plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
docker stop plex jackett radarr sonarr tautulli deluge ombi
docker rm plex jackett radarr sonarr tautulli deluge ombi
echo -e "${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi have been stopped and removed${NC}"


# Remove the network
echo -e "${Red}Removing the network my_plex_network${NC}"
docker network rm my_plex_network
echo -e "${Green}The network my_plex_network has been removed${NC}"
