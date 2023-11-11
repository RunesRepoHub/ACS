##########################################################################
#  Set variables  #
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

# Define error codes
SUCCESS="${Green}Error code: 0 (Success)${NC}"
INVALID_ARGUMENTS="${Yellow}Error code: 1 (Invalid arguments)${NC}"
FILE_NOT_FOUND="${Red}Error code: 2 (File not found)${NC}"
FILE_ALREADY_EXISTS="${Red}Error code: 3 (File already exists)${NC}"
PERMISSION_DENIED="${Red}Error code: 4 (Permission denied)${NC}"
NOT_INSTALLED="${Red}Error code: 5 (Not installed)${NC}"
UNKNOWN_ERROR="${Red}Error code: 99 (Unknown error)${NC}"

# Installer checks
# User checks before installation
# Reponses for user input
ABORT_INSTALL="${Red}Aborting installation.${NC}"
INSTALL_SUCCESSFUL="${Green}Installation successful.${NC}"
INSTALL_FAILED="${Red}Installation failed.${NC}"
INSTALL_MIGHT_FAIL="${Red}The installation might fail due to this error${NC}"
INSTALL_COMPLETED="${Green}Installation completed${NC}"
CUSTOM_COMMANDS="${Yellow}In order for the custom commands to load run 'source ~/.bashrc'${NC}"
CUSTOM_COMMANDS_HELP="${Orange}Find all custom commands here https://runesrepohub.github.io/YT-Plex/commands.html${NC}"
# Root user check
MUST_BE_ROOT="${Red}Must be root to run this.${NC}"
# Docker check
INSTALLATION_NEEDED="${Red}Install Docker and Docker-CLI before running Auto-YT-DL.${NC}"

# Setting up Auto-YT-DL
SETTING_UP_AUTO="${Purple}Setting up Auto-YT-DL...${NC}"
RUN_UPDATE="${Yellow}Run apt-get update${NC}"
RUN_UPGRADE="${Yellow}Run apt-get upgrade -y${NC}"

# Check if sudo is installed, if nor install it.
CHECK_SUDO="${Purple}Check if sudo is installed${NC}"
SUDO_INSTALLED="${Green}Sudo has been installed${NC}"
SUDO_NOT_INSTALLED="${Red}Sudo is not installed.${NC}"
SUDO_IS_ALREADY_INSTALLED="${Green}Sudo is already installed.${NC}"
SUDO_INSTALLING="${Yellow}Installing sudo...${NC}"

# Check if curl is installed, if nor install it.
CHECK_CURL="${Purple}Check if curl is installed${NC}"
CURL_INSTALLED="${Green}Curl has been installed${NC}"
CURL_NOT_INSTALLED="${Red}Curl is not installed.${NC}"
CURL_IS_ALREADY_INSTALLED="${Green}Curl is already installed.${NC}"
CURL_INSTALLING="${Yellow}Installing curl...${NC}"

# Download docker images
DOWNLOADING_DOCKER_IMAGES="${Purple}Downloading docker images${NC}"
DOCKER_IMAGES_DOWNLOADING="${Yellow}Downloading${NC}"
DOCKER_IMAGES_DOWNLOADED="${Green}has been downloaded.${NC}"
DOCKER_IMAGES_FOUND="${Green}is already downloaded.${NC}"

# Make the Root folder
ROOT_FOLDER=~/Auto-YT-DL/Scripts
ALREADY_EXISTS_ROOT="${Red}Folder ~/Auto-YT-DL/Scripts already exists.${NC}"
FOLDERS_EXISTS="${Red}Folders already exist.${NC}"
MAKE_ROOT_FOLDER="${Purple}Make the folder ~/Auto-YT-DL${NC}"
FOLDER_CREATED="${Green}Folder created${NC}"
FOLDERS_CREATED="${Green}Folders created${NC}"
MAKE_PLEX_FOLDERS="${Purple}Making folders for plex. media, transcode, and library...${NC}"

# Download other scripts
# Github repo link
GIHUB_LINK="https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Dev"
GITHUB_FOLDER="Scripts"
# Texts
REMOVING_OLD_SYSTEM_FILES="${Purple}Removing old system files for Auto-YT-DL and then downloading newest files...${NC}"
DOWNLOADING_NEW_FILES="${Green}Downloading new files complete${NC}"
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

# Make folders for Auto-YT-DL
YOUTUBE=~/plex/media/youtube 
TRANSCODE=~/plex/transcode 
LIBRARY=~/plex/library 
JACKETT=~/Auto-YT-DL/jackett 
RADARR=~/Auto-YT-DL/radarr 
MOVIES=~/plex/media/movies 
SONARR=~/Auto-YT-DL/sonarr 
SHOWS=~/plex/media/Shows 
MEDIA_DOWNLOAD=~/plex/media/download 
TAUTALLI=~/Auto-YT-DL/tautalli 
DELUGE=~/Auto-YT-DL/deluge 
OMBI=~/Auto-YT-DL/ombi  
DOWNLOAD_COMPLETED=~/plex/media/download/completed

# Container max
CONTAINER_MAX_TEXT="${Purple}Enter the maximum number of containers to run for the youtube downloader${NC}"
CONTAINER_INFO="${Yellow}These containers are used to download videos${NC}"
CONTAINER_MAX_FILE=~/Auto-YT-DL/.max_containers

# Cronjob
CRONJOB_TEXT="${Purple}Setup cronjob and alias${NC}"
# Cron timer
CRON_TIMER="0 0 30 * *"
# Cron job completed
CRON_COMPLETED="${Green}Cron job completed${NC}"

# Setup Plex
SETUP_PLEX_TEXT="${Purple}Making plex folders...${NC}"
SETUP_PLEX_COMPLETED="${Green}Setup plex completed${NC}"
SETUP_PLEX_FAILED="${Green}Plex docker is already running${NC}"

##########################################################################
# Start clean
clear 

# Check if user is root, if not then exit script
if [ "$(id -u)" -ne 0 ]; then
    echo -e "$PERMISSION_DENIED"
    echo -e "$MUST_BE_ROOT"
    echo -e "$ABORT_INSTALL"
    exit 1
fi

# Check if folder ~/Auto-YT-DL/Scripts exists
if [ -d $ROOT_FOLDER ]; then
    echo -e "$ALREADY_EXISTS"
    echo -e "$ALREADY_EXISTS_ROOT"
    echo -e "$ABORT_INSTALL"
    exit 1
fi

# Check if docker, docker cli, containerd.io, and docker-buildx-plugin are installed
if ! command -v docker &> /dev/null; then
    echo -e "$NOT_INSTALLED"
    echo -e "$INSTALLATION_NEEDED"
    echo -e "$ABORT_INSTALL"
    exit 1
fi

# Install needed tools for installation script to work
echo -e "$SETTING_UP_AUTO"
echo -e "$RUN_UPDATE"
apt-get update > /dev/null 2>&1
echo -e "$RUN_UPGRADE"
apt-get upgrade -y > /dev/null 2>&1

# Check if sudo is installed
echo -e "$CHECK_SUDO${NC}"
if ! command -v sudo &> /dev/null; then
    echo -e "$SUDO_NOT_INSTALLED"
    echo -e "$SUDO_INSTALLING"
    apt-get install sudo -y > /dev/null 2>&1
    echo -e "$SUDO_INSTALLED"
else
    echo -e "$SUDO_IS_ALREADY_INSTALLED"
fi 

# Check if curl is installed
echo -e "$CHECK_CURL"
if ! command -v curl &> /dev/null; then
    echo -e "$CURL_NOT_INSTALLED"
    echo -e "$CURL_INSTALLING"
    sudo apt-get install curl -y > /dev/null 2>&1
    echo -e "$CURL_INSTALLED"
else
    echo -e "$CURL_IS_ALREADY_INSTALLED"
fi

# Check if docker images are downloaded
echo -e "$DOWNLOADING_DOCKER_IMAGES"
images=("mikenye/youtube-dl" "plexinc/pms-docker" "lscr.io/linuxserver/jackett:latest" "lscr.io/linuxserver/radarr:latest" "lscr.io/linuxserver/sonarr:latest" "lscr.io/linuxserver/tautulli:latest" "lscr.io/linuxserver/deluge:latest" "lscr.io/linuxserver/ombi:latest") 
for image in "${images[@]}"; do
    if ! docker image inspect "$image" &> /dev/null; then
        echo -e "$DOCKER_IMAGES_DOWNLOADING $image..."
        docker pull "$image" > /dev/null 2>&1
        echo -e "$image $DOCKER_IMAGES_DOWNLOADED"
    else
        echo -e "$image $DOCKER_IMAGES_FOUND"
    fi
done

sleep 2

# Make the folder
echo -e "$MAKE_ROOT_FOLDER"
mkdir -p $ROOT_FOLDER
echo -e "$FOLDER_CREATED"

# Download files
echo -e "$REMOVING_OLD_SYSTEM_FILES"

if [ -e $ROOT_FOLDER/$AUTOMATED_CHECK ]; then
    rm $ROOT_FOLDER/$AUTOMATED_CHECK
fi
sleep 1
curl -s -o $ROOT_FOLDER/$AUTOMATED_CHECK $GIHUB_LINK/$GITHUB_FOLDER/$AUTOMATED_CHECK > /dev/null

if [ -e $ROOT_FOLDER/$SETUP_PLEX ]; then
    rm $ROOT_FOLDER/$SETUP_PLEX
fi
sleep 1
curl -s -o $ROOT_FOLDER/$SETUP_PLEX $GIHUB_LINK/$GITHUB_FOLDER/$SETUP_PLEX > /dev/null

if [ -e $ROOT_FOLDER/$DOWNLOAD ]; then
    rm $ROOT_FOLDER/$DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOWNLOAD $GIHUB_LINK/$GITHUB_FOLDER/$DOWNLOAD > /dev/null

if [ -e $ROOT_FOLDER/$DOCKER_STOP ]; then
    rm $ROOT_FOLDER/$DOCKER_STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOCKER_STOP $GIHUB_LINK/$GITHUB_FOLDER/$DOCKER_STOP > /dev/null

if [ -e $ROOT_FOLDER/$STOP ]; then
    rm $ROOT_FOLDER/$STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP $GIHUB_LINK/$GITHUB_FOLDER/$STOP > /dev/null

if [ -e $ROOT_FOLDER/$UNINSTALL ]; then
    rm $ROOT_FOLDER/$UNINSTALL
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UNINSTALL $GIHUB_LINK/$GITHUB_FOLDER/$UNINSTALL > /dev/null

if [ -e $ROOT_FOLDER/$STOP_REMOVE ]; then
    rm $ROOT_FOLDER/$STOP_REMOVE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP_REMOVE $GIHUB_LINK/$GITHUB_FOLDER/$STOP_REMOVE > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE ]; then
    rm $ROOT_FOLDER/$UPDATE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE $GIHUB_LINK/$GITHUB_FOLDER/$UPDATE > /dev/null

if [ -e $ROOT_FOLDER/$ADD_URL_LIST ]; then
    rm $ROOT_FOLDER/$ADD_URL_LIST
fi
sleep 1
curl -s -o $ROOT_FOLDER/$ADD_URL_LIST $GIHUB_LINK/$GITHUB_FOLDER/$ADD_URL_LIST > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE_DOWNLOAD ]; then
    rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD $GIHUB_LINK/Scripts/$UPDATE_DOWNLOAD > /dev/null

echo -e "$DOWNLOADING_NEW_FILES"

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "$MAKE_PLEX_FOLDERS"
if [ ! -d $YOUTUBE ] || [ ! -d $TRANSCODE ] || [ ! -d $LIBRARY ] || [ ! -d $JACKETT ] || [ ! -d $RADARR ] || [ ! -d $MOVIES ] || [ ! -d $SONARR ] || [ ! -d $SHOWS ] || [ ! -d $MEDIA_DOWNLOAD ] || [ ! -d $TAUTALLI ] || [ ! -d $DELUGE ] || [ ! -d $OMBI ] || [ ! -d $DOWNLOAD_COMPLETED ]; then
    # Create the folders if they don't exist
    mkdir -p $YOUTUBE $TRANSCODE $LIBRARY $JACKETT $RADARR $MOVIES $SONARR $SHOWS $MEDIA_DOWNLOAD $TAUTALLI $DELUGE $OMBI $DOWNLOAD_COMPLETED
else
    echo -e "$ALREADY_EXISTS"
    echo -e "$FOLDERS_EXISTS"
    echo -e "$INSTALL_MIGHT_FAIL"
fi
echo -e "$FOLDERS_CREATED"

chmod 777 $MOVIES
chmod 777 $SHOWS
chmod 777 $MEDIA_DOWNLOAD
chmod 777 $DOWNLOAD_COMPLETED

# Take user input and save it to a file
echo -e "$CONTAINER_MAX_TEXT"
echo -e "$CONTAINER_INFO"
read -p "Max Containers: " userInput
echo "$userInput" > $CONTAINER_MAX_FILE

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
if ! docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
    bash ~/Auto-YT-DL/Scripts/setup-plex.sh
    echo -e "$SETUP_PLEX_COMPLETED"
else
    echo -e "$SETUP_PLEX_FAILED"
fi

# Add alias
echo -e "$CRONJOB_TEXT"
# Add aliases to the shell configuration file
echo 'alias add-url="bash '$ROOT_FOLDER'/'$ADD_URL_LIST'"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias start-download="bash '$ROOT_FOLDER'/'$AUTOMATED_CHECK'"' >> ~/.bashrc
echo 'alias stop-download="bash '$ROOT_FOLDER'/'$DOCKER_STOP'"' >> ~/.bashrc
echo 'alias stop-all="bash '$ROOT_FOLDER'/'$STOP'"' >> ~/.bashrc
echo 'alias yt-uninstall="bash '$ROOT_FOLDER'/'$UNINSTALL'"' >> ~/.bashrc
echo 'alias yt-update="bash '$ROOT_FOLDER'/'$UPDATE'"' >> ~/.bashrc
echo 'alias remove-all="bash '$ROOT_FOLDER'/'$STOP_REMOVE'"' >> ~/.bashrc

# Add the cronjob
echo "$CRON_TIMER root bash $ROOT_FOLDER/$AUTOMATED_CHECK" | sudo tee -a /etc/crontab >/dev/null
echo -e "$CRON_COMPLETED"

sleep 2 
# Remove files
rm $ROOT_FOLDER/$SETUP_PLEX

echo 
echo -e "$INSTALL_COMPLETED"
echo -e "$CUSTOM_COMMANDS"
echo -e "$CUSTOM_COMMANDS_HELP"