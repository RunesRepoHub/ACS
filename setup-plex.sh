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

# Set the IP address and time zone
IP=$(hostname -I | awk '{print $1}')
TZ=$(timedatectl show --property=Timezone --value)

echo -e "${Green}Claim the Plex server${NC}"
echo -e "${Green}https://www.plex.tv/claim/${NC}"

# Prompt the user for the Plex claim
read -p "Enter the Plex claim: " PLEX_CLAIM

docker run \
    -d \
    --name plex \
    -p 32400:32400/tcp \
    -p 3005:3005/tcp \
    -p 8324:8324/tcp \
    -p 32469:32469/tcp \
    -p 1900:1900/udp \
    -p 32410:32410/udp \
    -p 32412:32412/udp \
    -p 32413:32413/udp \
    -p 32414:32414/udp \
    -e TZ="$TZ" \
    -e PLEX_CLAIM="$PLEX_CLAIM" \
    -e ADVERTISE_IP="http://$IP:32400/" \
    -h plex-server \
    -v ~/plex/library:/config \
    -v ~/plex/transcode/temp:/transcode \
    -v ~/plex/media:/data \
    plexinc/pms-docker

