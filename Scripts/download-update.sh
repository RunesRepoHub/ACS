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

# Make the Root folder
ROOT_FOLDER=~/Auto-YT-DL/Scripts

# Github repo link
GIHUB_LINK="https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production"

# All script names
AUTOMATED_CHECK="automated-check.sh"
ADD_URL_LIST="add-url-list.sh"
DOCKER_STOP="docker-stop.sh"
STOP="stop.sh"
STOP_REMOVE="stop-remove.sh"
UNINSTALL="uninstall.sh"
UPDATE="update.sh"
UPDATE_DOWNLOAD="update-download.sh"
SETUP_PLEX="setup-plex.sh"
DOWNLOAD="download.sh"

# Texts
REMOVING_OLD_SYSTEM_FILES="${Purple}Removing old system files for Auto-YT-DL and then downloading newest files...${NC}"
DOWNLOADING_NEW_FILES="${Green}Downloading new files complete${NC}"

# Download files
echo -e "$REMOVING_OLD_SYSTEM_FILES"


if [ -e $ROOT_FOLDER/$AUTOMATED_CHECK ]; then
    rm $ROOT_FOLDER/$AUTOMATED_CHECK
fi
sleep 1
curl -s -o $ROOT_FOLDER/$AUTOMATED_CHECK $GIHUB_LINK/Scripts/$AUTOMATED_CHECK > /dev/null

if [ -e $ROOT_FOLDER/$SETUP_PLEX ]; then
    rm $ROOT_FOLDER/$SETUP_PLEX
fi
sleep 1
curl -s -o $ROOT_FOLDER/$SETUP_PLEX $GIHUB_LINK/Scripts/$SETUP_PLEX > /dev/null

if [ -e $ROOT_FOLDER/$DOWNLOAD ]; then
    rm $ROOT_FOLDER/$DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOWNLOAD $GIHUB_LINK/Scripts/$DOWNLOAD > /dev/null

if [ -e $ROOT_FOLDER/$DOCKER_STOP ]; then
    rm $ROOT_FOLDER/$DOCKER_STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOCKER_STOP $GIHUB_LINK/Scripts/$DOCKER_STOP > /dev/null

if [ -e $ROOT_FOLDER/$STOP ]; then
    rm $ROOT_FOLDER/$STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP $GIHUB_LINK/Scripts/$STOP > /dev/null

if [ -e $ROOT_FOLDER/$UNINSTALL ]; then
    rm $ROOT_FOLDER/$UNINSTALL
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UNINSTALL $GIHUB_LINK/Scripts/$UNINSTALL > /dev/null

if [ -e $ROOT_FOLDER/$STOP_REMOVE ]; then
    rm $ROOT_FOLDER/$STOP_REMOVE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP_REMOVE $GIHUB_LINK/Scripts/$STOP_REMOVE > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE ]; then
    rm $ROOT_FOLDER/$UPDATE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE $GIHUB_LINK/Scripts/$UPDATE > /dev/null

if [ -e $ROOT_FOLDER/$ADD_URL_LIST ]; then
    rm $ROOT_FOLDER/$ADD_URL_LIST
fi
sleep 1
curl -s -o $ROOT_FOLDER/$ADD_URL_LIST $GIHUB_LINK/Scripts/$ADD_URL_LIST > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE_DOWNLOAD ]; then
    rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD $GIHUB_LINK/Scripts/$UPDATE_DOWNLOAD > /dev/null

echo -e "$DOWNLOADING_NEW_FILES"