#!/bin/bash

#############
### TO-DO ###
#############
### Change source to new repo name
### source ~/Auto-YT-DL/Scripts/Core.sh

# start any docker with the image mikenye/youtube-dl
echo -e "${Purple}Starting any and all mikenye/youtube-dl dockers${NC}"
container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
    docker start $container_id
done
echo -e "${Green}This may take a while...${NC}"
echo -e "${Green}All mikenye/youtube-dl dockers have been started${NC}"

# Start the dockers
echo -e "${Red}Starting plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
docker start plex jackett radarr sonarr tautulli deluge ombi
echo -e "${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi have been started${NC}"
