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
docker rm plex jackett radarr sonarr tautulli deluge ombi
echo -e "${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"

echo -e "${Purple}Do you want to save all the files in the plex media folder or delete them?${NC}"
echo -e "${Green}y = Keep plex media folder${NC}"
echo -e "${Red}n = Delete plex media folder${NC}"

# Prompt the user for a yes/no answer
read -p "Are you sure? (y/n): " answer

# Check the user's response
if [[ $answer == "y" ]]; then
    # User answered "yes"
    # run docker stop all
    bash ~/Auto-YT-DL/stop.sh
    sleep 2
    # remove all folders and files
    rm -rf ~/Auto-YT-DL  ~/deluge  ~/download  ~/jackett  ~/ombi  ~/radarr  ~/sonarr  ~/tautalli
    echo -e "${Green}All folders and files has been removed except the plex media folder, all dockers has been stopped${NC}"

    # Remove the line from the crontab file
    sudo sed -i '/Auto-YT-DL\/automated-check.sh/d' /etc/crontab
    
elif [[ $answer == "n" ]]; then
    # User answered "no"
    # run docker stop all
    bash ~/Auto-YT-DL/stop-remove.sh
    sleep 2
    # remove all folders and files
    rm -rf ~/Auto-YT-DL  ~/deluge  ~/download  ~/jackett  ~/ombi  ~/plex  ~/radarr  ~/sonarr  ~/tautalli
    echo -e "${Green}All folders and files has been removed, all dockers has been stopped${NC}"
else
    # User entered an invalid response
    echo -e "${Red}Error code: 400${NC}"
    echo -e "${Red}Invalid input!${NC}"
fi

