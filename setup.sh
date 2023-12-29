#!/bin/bash

# Check if the folder already exists
set -e
if [ -d ~/ACS ]; then
    echo "Folder already exists. Aborting script."
    exit 1
else
    echo "Folder does not exist. Continuing the script."
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    # Install git
    echo "Git is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y git
    echo "Git installation completed."
fi

git clone https://github.com/RunesRepoHub/ACS.git
source ~/ACS/Scripts/Core.sh
chmod +x ~/ACS/Scripts/Core.sh



##########################################################################
# Start clean
clear 


#############
### TO-DO ###
#############
### Check paths


# Check if user is root, if not then exit script
if [ "$(id -u)" -ne 0 ]; then
    echo -e "${Red}Error code: 4 (Permission denied)${NC}"
    echo -e "${Red}Must be root to run this.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if folder ~/Auto-YT-DL/Scripts exists
if [ -d $ROOT_FOLDER ]; then
    echo -e "${Red}Error code: 3 (File already exists)${NC}"
    echo -e "${Red}Folder ~/Auto-YT-DL/Scripts already exists.${NC}"
    echo -e "${Red}Aborting installation.${NC}"        #### Find and fix this
    exit 1
fi

# Check if docker, docker cli, containerd.io, and docker-buildx-plugin are installed
if ! command -v docker &> /dev/null; then
    echo -e "${Red}Error code: 5 (Not installed)${NC}"
    echo -e "${Red}Install Docker and Docker-CLI before running Auto-YT-DL.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if sudo is installed
echo -e "${Purple}Check if sudo is installed${NC}"
if ! command -v sudo &> /dev/null; then
    echo -e "${Red}Sudo is not installed.${NC}"
    echo -e "${Yellow}Installing sudo...${NC}"
    apt-get install sudo -y > /dev/null 2>&1
    echo -e "${Green}Sudo has been installed${NC}"
else
    echo -e "${Green}Sudo is already installed.${NC}"
fi 

# Check if curl is installed
echo -e "${Purple}Check if curl is installed${NC}"
if ! command -v curl &> /dev/null; then
    echo -e "${Red}Curl is not installed.${NC}"
    echo -e "${Yellow}Installing curl...${NC}"
    sudo apt-get install curl -y > /dev/null 2>&1
    echo -e "${Green}Curl has been installed${NC}"
else
    echo -e "${Green}Curl is already installed.${NC}"
fi

#############
### TO-DO ###
#############
### Make this into a setup script for ACSF or any other new system


# Install needed tools for installation script to work
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"
echo -e "${Yellow}Run apt-get update${NC}"
apt-get update > /dev/null 2>&1
echo -e "${Yellow}Run apt-get upgrade -y${NC}"
apt-get upgrade -y > /dev/null 2>&1

# Check if docker images are downloaded
echo -e "${Purple}Downloading docker images${NC}"
images=("mikenye/youtube-dl" "plexinc/pms-docker" "lscr.io/linuxserver/jackett:latest" "lscr.io/linuxserver/radarr:latest" "lscr.io/linuxserver/sonarr:latest" "lscr.io/linuxserver/tautulli:latest" "lscr.io/linuxserver/deluge:latest" "lscr.io/linuxserver/ombi:latest") 
for image in "${images[@]}"; do
    if ! docker image inspect "$image" &> /dev/null; then
        echo -e "${Yellow}Downloading${NC} ${Blue}$image...${NC}"
        docker pull "$image" > /dev/null 2>&1
        echo -e "${Blue}$image${NC} ${Green}has been downloaded.${NC}"
    else
        echo -e "${LightBlue}$image${NC} ${Green}is already downloaded.${NC}"
    fi
done

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
if [ ! -d $YOUTUBE ] || [ ! -d $TRANSCODE ] || [ ! -d $LIBRARY ] || [ ! -d $JACKETT ] || [ ! -d $RADARR ] || [ ! -d $MOVIES ] || [ ! -d $SONARR ] || [ ! -d $SHOWS ] || [ ! -d $MEDIA_DOWNLOAD ] || [ ! -d $TAUTALLI ] || [ ! -d $DELUGE ] || [ ! -d $OMBI ] || [ ! -d $DOWNLOAD_COMPLETED ]; then
    # Create the folders if they don't exist
    mkdir -p $YOUTUBE $TRANSCODE $LIBRARY $JACKETT $RADARR $MOVIES $SONARR $SHOWS $MEDIA_DOWNLOAD $TAUTALLI $DELUGE $OMBI $DOWNLOAD_COMPLETED
else
    echo -e "${Red}Folders already exist.${NC}"
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
echo "$userInput" > $CONTAINER_MAX_FILE

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
if ! docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
    bash ~/Auto-YT-DL/Scripts/setup-plex.sh
    echo -e "${Green}Setup plex completed${NC}"
else
    echo -e "${Green}Plex docker is already running${NC}"
fi

# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file
echo 'alias add-url="bash '$ROOT_FOLDER'/'$ADD_URL_LIST'"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias start-download="bash '$ROOT_FOLDER'/'$AUTOMATED_CHECK'"' >> ~/.bashrc
echo 'alias stop-download="bash '$ROOT_FOLDER'/'$DOCKER_STOP'"' >> ~/.bashrc
echo 'alias stop-all="bash '$ROOT_FOLDER'/'$STOP'"' >> ~/.bashrc
echo 'alias start-all="bash '$ROOT_FOLDER'/'$START'"' >> ~/.bashrc
echo 'alias yt-uninstall="bash '$ROOT_FOLDER'/'$UNINSTALL'"' >> ~/.bashrc
echo 'alias yt-update="bash '$ROOT_FOLDER'/'$UPDATE'"' >> ~/.bashrc
echo 'alias remove-all="bash '$ROOT_FOLDER'/'$STOP_REMOVE'"' >> ~/.bashrc
echo 'alias acs-usage="bash '$ROOT_FOLDER'/'$USAGE'"' >> ~/.bashrc
echo 'alias acs-convert="bash '$ROOT_FOLDER'/'$CONVERT'"' >> ~/.bashrc

# Add the cronjob
echo "$CRON_TIMER root bash $ROOT_FOLDER/$AUTOMATED_CHECK" | sudo tee -a /etc/crontab >/dev/null
echo -e "${Green}Cron job completed${NC}"

echo 
echo -e "${Green}Installation completed${NC}"
echo -e "${Yellow}In order for the custom commands to load run 'source ~/.bashrc'${NC}"
echo -e "${BrownOrange}Find all custom commands here https://runesrepohub.github.io/ACS/commands.html${NC}"