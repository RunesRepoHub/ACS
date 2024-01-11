#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Set the IP address and time zone
IP=$(hostname -I | awk '{print $1}')
TZ=$(timedatectl show --property=Timezone --value)

# Check if the network already exists
if docker network inspect my_plex_network >/dev/null 2>&1; then
    echo -e "${Red}The network my_plex_network already exists${NC}"
    echo -e "${Red}The installation might fail due to this error${NC}"
else
    # Create the network
    docker network create my_plex_network
fi

# Check if there is already a docker with the name plex running

if docker ps -a --format '{{.Names}}' | grep -q "^plex$"; then
    echo -e "${Green}Plex is already running skipping plex claim${NC}"
else
    echo -e "${Green}Claim the Plex server${NC}"
    echo -e "${Green}https://www.plex.tv/claim/${NC}"

    # Prompt the user for the Plex claim
    read -p "Enter the Plex claim: " PLEX_CLAIM

    # Check if PLEX_CLAIM is empty
    if [ -z "$PLEX_CLAIM" ]; then
        echo -e "${Yellow}Error code: 1 (Invalid arguments)${NC}"
        exit 1
    fi


    echo -e "${Green}Enter the hostname that you want for the plex server in the plex settings${NC}"    
    # Prompt the user for the hostname
    read -p "Hostname for Plex-Server: " PLEX_HOST
fi


# Append environment variables to the ~/ACS/Dockers/.env file
{
    echo "IP=$IP"
    echo "TZ=$TZ"
    echo "PLEX_CLAIM=$PLEX_CLAIM"
    echo "PLEX_HOST=$PLEX_HOST"
} >> ~/ACS/Dockers/.env


# Find all docker-compose files in the Dockers directory and its subdirectories
docker_compose_files=$(find ~/ACS/Dockers -name 'docker-compose.yml')

# Loop through each docker-compose file and run them
for file in $docker_compose_files; do
    echo -e "${Green}Running docker-compose file: $file${NC}"
    docker compose -f "$file" up -d
done
