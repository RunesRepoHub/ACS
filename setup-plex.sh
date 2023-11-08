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

# Create a network
docker network create my_plex_network

# Run the plex service
docker run \
    -d \
    --name plex \
    --network my_plex_network \
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

# Run the jackett service
docker run -d \
  --name jackett \
  --network my_plex_network \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europa/Copenhagen \
  -e AUTO_UPDATE=true \
  -v ~/jackett:/config \
  -v ~/download/downloading:/downloads \
  -p 9117:9117 \
  --restart unless-stopped \
  lscr.io/linuxserver/jackett:latest

# Run the radarr service
docker run -d \
  --name radarr \
  --network my_plex_network \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ=Europa/Copenhagen \
  -v ~/radarr:/config \
  -v ~/plex/media/movies:/movies \
  -v ~/download/downloading_completed:/downloads \
  -p 7878:7878 \
  --restart unless-stopped \
  lscr.io/linuxserver/radarr:latest

# Run the sonarr service
docker run -d \
  --name sonarr \
  --network my_plex_network \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ=Europa/Copenhagen \
  -v ~/sonarr:/config \
  -v ~/plex/media/Shows:/shows \
  -v ~/download/downloading_completed:/downloads \
  -p 8989:8989 \
  --restart unless-stopped \
  lscr.io/linuxserver/sonarr:latest

# Run the tautulli service
docker run -d \
  --name tautulli \
  --network my_plex_network \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europa/Copenhagen \
  -v ~/tautalli:/config \
  -p 8181:8181 \
  --restart unless-stopped \
  lscr.io/linuxserver/tautulli:latest

# Run the deluge service
docker run -d \
  --name deluge \
  --network my_plex_network \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ=Europa/Copenhagen \
  -e DELUGE_LOGLEVEL=error \
  -v ~/deluge:/config \
  -v ~/download:/downloads \
  -p 8112:8112 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  --restart unless-stopped \
  lscr.io/linuxserver/deluge:latest

# Run the ombi service
docker run -d \
  --name ombi \
  --network my_plex_network \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Europa/Copenhagen \
  -v ~/ombi:/config \
  -p 3579:3579 \
  --restart unless-stopped \
  lscr.io/linuxserver/ombi:latest

