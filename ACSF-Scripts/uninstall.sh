#!/bin/bash

source ~/ACS/Scripts/Core.sh

echo -e "${Purple}Do you want to save all the files in the plex media folder or delete them?${NC}"
echo -e "${Green}y = Keep plex media folder${NC}"
echo -e "${Red}n = Delete plex media folder${NC}"

# Prompt the user for a yes/no answer
read -p "Are you sure? (y/n): " answer

# Check the user's response
if [[ $answer == "y" ]]; then
    # User answered "yes"
    
    # Stop and remove any docker with the image mikenye/youtube-dl
    echo -e "${Red}Stopping any and all mikenye/youtube-dl dockers then delete them${NC}"
    container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
    for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
        docker stop $container_id
    done
    echo -e "${Green}All mikenye/youtube-dl dockers have been stopped and removed${NC}"
    
    # Stop and remove the dockers
    echo -e "${Red}Stopping jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
    docker stop jackett radarr sonarr tautulli deluge ombi 
    docker rm jackett radarr sonarr tautulli deluge ombi
    echo -e "${Green}All jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"

        # Remove the network
    echo -e "${Red}Removing the network my_plex_network${NC}"
    docker network rm my_plex_network
    echo -e "${Green}The network my_plex_network has been removed${NC}"

    # remove all folders and files
    rm -rf ~/Auto-YT-DL 
    echo -e "${Green}All folders and files has been removed except the plex media folder, all dockers has been stopped${NC}"

    # Remove the line from the crontab file
    sudo sed -i '/Auto-YT-DL\/Scripts\/automated-check.sh/d' /etc/crontab
    
elif [[ $answer == "n" ]]; then
    # User answered "no"
    
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

    # remove all folders and files
    echo -e "${Purple}Cleanup all folders and files...${NC}"
    rm -rf ~/Auto-YT-DL  ~/plex
    echo -e "${Green}All folders and files has been removed except the plex media folder, all dockers has been stopped${NC}"

    # Remove the line from the crontab file
    sudo sed -i '/Auto-YT-DL\/Scripts\/automated-check.sh/d' /etc/crontab
else
    # User entered an invalid response
    echo -e "${Red}Error code: 400${NC}"
    echo -e "${Red}Invalid input!${NC}"
fi

