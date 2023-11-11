#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh


echo -e "$USER_TEXT_SAVE_PLEX"
echo -e "$USER_ANSWER_SAVE_PLEX"
echo -e "$USER_ANSWER_DELETE_PLEX"

# Prompt the user for a yes/no answer
read -p "Are you sure? (y/n): " answer

# Check the user's response
if [[ $answer == "y" ]]; then
    # User answered "yes"
    
    # Stop and remove any docker with the image mikenye/youtube-dl
    echo -e "$YOUTUBE_DL_STOP"
    container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
    for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
        docker stop $container_id
    done
    echo -e "$YOUTUBE_DL_STOP_REMOVE_COMPLETED"
    
    # Stop and remove the dockers
    echo -e "$CLEANUP_NOTPLEX"
    docker stop jackett radarr sonarr tautulli deluge ombi 
    docker rm jackett radarr sonarr tautulli deluge ombi
    echo -e "$CLEANUP_NOTPLEX_COMPLETED"

        # Remove the network
    echo -e "$DOCKER_NETWORK_STOP_REMOVE"
    docker network rm my_plex_network
    echo -e "$DOCKER_NETWORK_STOP_REMOVE_COMPLETED"

    # remove all folders and files
    rm -rf ~/Auto-YT-DL 
    echo -e "$CLEANUP_DONT_DELETE_PLEX"

    # Remove the line from the crontab file
    sudo sed -i '/Auto-YT-DL\/Scripts\/automated-check.sh/d' /etc/crontab
    
elif [[ $answer == "n" ]]; then
    # User answered "no"
    
    # Stop and remove any docker with the image mikenye/youtube-dl
    echo -e "$YOUTUBE_DL_STOP"
    container_count=$(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}" | wc -l)
    for container_id in $(docker ps -a --filter="ancestor=mikenye/youtube-dl" --format "{{.ID}}"); do
        docker stop $container_id
    done
    echo -e "$YOUTUBE_DL_STOP_REMOVE_COMPLETED"
    
    # Stop and remove the dockers
    echo -e "$DOCKER_STOP_REMOVE_TEXT"
    docker stop plex jackett radarr sonarr tautulli deluge ombi 
    docker rm plex jackett radarr sonarr tautulli deluge ombi
    echo -e "$DOCKER_STOP_REMOVE_COMPLETED"
    
    # Remove the network
    echo -e "$DOCKER_NETWORK_STOP_REMOVE"
    docker network rm my_plex_network
    echo -e "$DOCKER_NETWORK_STOP_REMOVE_COMPLETED"

    # remove all folders and files
    echo -e "$CLEANUP_ALL"
    rm -rf ~/Auto-YT-DL  ~/plex
    echo -e "$CLEANUP_ALL_COMPLETED"

    # Remove the line from the crontab file
    sudo sed -i '/Auto-YT-DL\/Scripts\/automated-check.sh/d' /etc/crontab
else
    # User entered an invalid response
    echo -e "${Red}Error code: 400${NC}"
    echo -e "${Red}Invalid input!${NC}"
fi

