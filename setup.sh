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

# User checks before installation
ABORT_INSTALL="${Red}Aborting installation.${NC}"
INSTALL_SUCCESSFUL="${Green}Installation successful.${NC}"
INSTALL_FAILED="${Red}Installation failed.${NC}"
INSTALLATION_NEEDED="${Red}Install Docker and Docker-CLI before running Auto-YT-DL.${NC}"
MUST_BE_ROOT="${Red}Must be root to run this.${NC}"

# Make the Root folder
ROOT_FOLDER=~/Auto-YT-DL/Scripts
ALREADY_EXISTS_ROOT="${Red}Folder ~/Auto-YT-DL/Scripts already exists.${NC}"
FOLDERS_EXISTS="${Red}Folders already exist.${NC}"
MAKE_ROOT_FOLDER="${Purple}Make the folder ~/Auto-YT-DL${NC}"
FOLDER_CREATED="${Green}Folder created${NC}"

# Github repo link
GIHUB_LINK="https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production"

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

# Setting up Auto-YT-DL
SETTING_UP_AUTO="${Purple}Setting up Auto-YT-DL...${NC}"
RUN_UPDATE="${Yellow}Run apt-get update${NC}"
RUN_UPGRADE="${Yellow}Run apt-get upgrade -y${NC}"

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
echo -e "${Purple}Check if sudo is installed${NC}"
if ! command -v sudo &> /dev/null; then
    echo -e "${Purple}Sudo is not installed.${NC}"
    echo -e "${Yellow}Installing sudo...${NC}"
    apt-get install sudo -y > /dev/null 2>&1
    echo -e "${Green}Sudo has been installed.${NC}"
else
    echo -e "${Green}Sudo is already installed.${NC}"
fi 

# Check if curl is installed
echo -e "${Purple}Check if curl is installed${NC}"
if ! command -v curl &> /dev/null; then
    echo -e "${Purple}Curl is not installed.${NC}"
    echo -e "${Yellow}Installing curl...${NC}"
    sudo apt-get install curl -y > /dev/null 2>&1
    echo -e "${Green}Curl has been installed.${NC}"
else
    echo -e "${Green}Curl is already installed.${NC}"
fi

# Check if docker and docker-compose are installed
echo -e "${Purple}Check if docker and docker-compose is installed${NC}"
if ! command -v docker &> /dev/null; then
    echo -e "${Red}Docker is not installed.${NC}"
    echo -e "${Yellow}Please install docker in order to install Auto-YT-DL${NC}"
    break 2
else
    echo -e "${Green}Docker is installed.${NC}"
fi

# Check if docker images are downloaded
echo -e "${Purple}Downloading docker images${NC}"
images=("mikenye/youtube-dl" "plexinc/pms-docker" "lscr.io/linuxserver/jackett:latest" "lscr.io/linuxserver/radarr:latest" "lscr.io/linuxserver/sonarr:latest" "lscr.io/linuxserver/tautulli:latest" "lscr.io/linuxserver/deluge:latest" "lscr.io/linuxserver/ombi:latest") 
for image in "${images[@]}"; do
    if ! docker image inspect "$image" &> /dev/null; then
        echo -e "${Yellow}Downloading $image...${NC}"
        docker pull "$image" > /dev/null 2>&1
        echo -e "${Green}$image has been downloaded.${NC}"
    else
        echo -e "${Green}$image is already downloaded.${NC}"
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

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ] || [ ! -d ~/Auto-YT-DL/jackett ] || [ ! -d ~/Auto-YT-DL/radarr ] || [ ! -d ~/plex/media/movies ] || [ ! -d ~/sonarr ] || [ ! -d ~/plex/media/Shows ] || [ ! -d ~/plex/media/download ] || [ ! -d ~/Auto-YT-DL/tautalli ] || [ ! -d ~/Auto-YT-DL/deluge ] || [ ! -d ~/Auto-YT-DL/ombi ] || [ ! -d ~/plex/media/download/completed ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library ~/Auto-YT-DL/jackett ~/Auto-YT-DL/radarr ~/plex/media/movies ~/Auto-YT-DL/sonarr ~/plex/media/Shows ~/plex/media/download ~/Auto-YT-DL/tautalli ~/Auto-YT-DL/deluge ~/Auto-YT-DL/ombi  ~/plex/media/download/completed
else
    echo -e "$ALREADY_EXISTS"
    echo -e "$FOLDERS_EXISTS"
    echo -e "${Red}The installation might fail due to this error${NC}"
fi
echo -e "${Green}Folders created${NC}"

chmod 777 $MOVIES
chmod 777 $SHOWS
chmod 777 $MEDIA_DOWNLOAD
chmod 777 $DOWNLOAD_COMPLETED

# Take user input and save it to a file
echo -e "${Purple}Enter the maximum number of containers to run for the youtube downloader${NC}"
echo -e "${Yellow}These containers are used to download videos${NC}"
read -p "Max Containers: " userInput
echo "$userInput" > ~/Auto-YT-DL/.max_containers

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
if ! docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
    bash ~/Auto-YT-DL/Scripts/setup-plex.sh
else
    echo -e "${Green}Plex docker is already running${NC}"
fi

# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file
echo 'alias add-url="bash ~/Auto-YT-DL/Scripts/add-url-list.sh"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias start-download="bash ~/Auto-YT-DL/Scripts/automated-check.sh"' >> ~/.bashrc
echo 'alias stop-download="bash ~/Auto-YT-DL/Scripts/docker-stop.sh"' >> ~/.bashrc
echo 'alias stop-all="bash ~/Auto-YT-DL/Scripts/stop.sh"' >> ~/.bashrc
echo 'alias yt-uninstall="bash ~/Auto-YT-DL/Scripts/uninstall.sh"' >> ~/.bashrc
echo 'alias yt-update="bash ~/Auto-YT-DL/Scripts/update.sh"' >> ~/.bashrc
echo 'alias remove-all="bash ~/Auto-YT-DL/Scripts/stop-remove.sh"' >> ~/.bashrc


# Add the cronjob
echo "0 0 30 * * root bash ~/Auto-YT-DL/Scripts/automated-check.sh" | sudo tee -a /etc/crontab >/dev/null
echo -e "${Green}Cron job added successfully.${NC}"

sleep 2 
# Remove files
rm ~/Auto-YT-DL/Scripts/setup-plex.sh


echo 
echo -e "${Green}Installation completed${NC}"
echo -e "${Yellow}In order for the custom commands to load run 'source ~/.bashrc'${NC}"
echo -e "${Orange}Find all custom commands here https://github.com/RunesRepoHub/YT-Plex#easy-command${NC}"