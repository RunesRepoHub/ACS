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


if [ -e ~/Auto-YT-DL/Scripts/automated-check.sh ]; then
    rm ~/Auto-YT-DL/Scripts/automated-check.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/automated-check.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/setup-plex.sh ]; then
    rm ~/Auto-YT-DL/Scripts/setup-plex.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/setup-plex.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/download.sh ]; then
    rm ~/Auto-YT-DL/Scripts/download.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/download.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/download.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/docker-stop.sh ]; then
    rm ~/Auto-YT-DL/Scripts/docker-stop.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/docker-stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/docker-stop.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/stop.sh ]; then
    rm ~/Auto-YT-DL/Scripts/stop.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/stop.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/uninstall.sh ]; then
    rm ~/Auto-YT-DL/Scripts/uninstall.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/uninstall.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/uninstall.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/stop-remove.sh ]; then
    rm ~/Auto-YT-DL/Scripts/stop-remove.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/stop-remove.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/stop-remove.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/update.sh ]; then
    rm ~/Auto-YT-DL/Scripts/update.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/update.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/update.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/add-url-list.sh ]; then
    rm ~/Auto-YT-DL/Scripts/add-url-list.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/add-url-list.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/add-url-list.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/update-download.sh ]; then
    rm ~/Auto-YT-DL/Scripts/update-download.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/update-download.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/update-download.sh > /dev/null

echo -e "${Green}Downloading files complete${NC}"