#!/bin/bash
# Stop and remove any docker with the image mikenye/youtube-dl

source ~/ACS/Scripts/Core.sh


echo -e "${Green}Stopping all mikenye/youtube-dl containers...${NC}"
echo -e "${Green}This may take a while...${NC}"

# Get the container IDs
container_ids=$(docker ps -q --filter ancestor=mikenye/youtube-dl)

# Send a stop command to all containers
for container_id in $container_ids; do
    docker stop $container_id
done