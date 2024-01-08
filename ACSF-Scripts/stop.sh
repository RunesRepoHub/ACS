#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "${Green}Stopping all mikenye/youtube-dl containers...${NC}"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker stop $container_id
done
echo -e "${Green}This may take a while...${NC}"
echo -e "${Green}Stopped all mikenye/youtube-dl containers${NC}"

# Stop and remove the dockers
echo -e "${Red}Stopping plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
docker stop plex jackett radarr sonarr tautulli deluge ombi
echo -e "${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"
