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

# Download files
echo -e "${Purple}Removing old system files for Auto-YT-DL and then downloading newest files...${NC}"


rm ~/Auto-YT-DL/Scripts/automated-check.sh

sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/YT-Plex/$Dev/automated-check.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/add-url.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/add-url.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/setup-plex.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/setup-plex.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/download.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/download.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/download.sh > /dev/null


rm ~/Auto-YT-DL/Scripts/docker-stop.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/docker-stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/docker-stop.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/docker-compose.yml
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/docker-compose.yml https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/docker-compose.yml > /dev/null

rm ~/Auto-YT-DL/Scripts/stop.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/stop.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/uninstall.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/uninstall.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/uninstall.sh > /dev/null

rm ~/Auto-YT-DL/Scripts/stop-remove.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/stop-remove.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/stop-remove.sh > /dev/null

echo -e "${Green}Downloading files complete${NC}"