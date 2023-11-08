#!/bin/bash

##### Styles ######
Black='\e[0;30m'
DarkGray='\e[1;30m'
Red='\e[0;31m'
LightRed='\e[1;31m'
Green='\e[0;32m'
LightGreen='\e[1;32m'
BrownOrange='\e[0;33m'
Yellow='\e[1;33m'
Blue='\e[0;34m'
LightBlue='\e[1;34m'
Purple='\e[0;35m'
LightPurple='\e[1;35m'
Cyan='\e[0;36m'
LightCyan='\e[1;36m'
LightGray='\e[0;37m'
White='\e[1;37m'
NC='\e[0m'  # Reset to default
###################

# Stop and remove any docker with the image mikenye/youtube-dl
echo -e "${Red}Stopping any and all mikenye/youtube-dl dockers${NC}"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker stop $container_id
done
echo -e "${Green}All mikenye/youtube-dl dockers have been stopped and removed${NC}"


# Stop and remove the dockers
echo -e "${Red}Stopping plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
docker stop plex jackett radarr sonarr tautulli deluge ombi
echo -e "${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"
