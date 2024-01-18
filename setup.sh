#!/bin/bash

# Check if the folder already exists
set -e
if [ -d ~/ACS ]; then
    echo -e "${Yellow}ACS folder already exists. Pulling latest changes...${NC}"
    git pull 
else
    echo "${Yellow}Folder does not exist. Continuing the script.${NC}"
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    # Install git
    echo "Git is not installed. Installing..."
    sudo apt-get update
    sudo apt-get install -y git
    echo "Git installation completed."
fi

if [ -d ~/ACS ]; then
    echo -e "${Yellow}ACS has been updated${NC}"
else
    read -p "Enter the branch you want to clone: " branch
    git clone --branch "$branch" https://github.com/RunesRepoHub/ACS.git
fi

chmod +x ~/ACS/ACSF-Scripts/Core.sh
source ~/ACS/ACSF-Scripts/Core.sh

cd ~/ACS

# Configure git to only allow fast-forward pulls
git config --global pull.ff only

cd ..

# Start clean
clear 

# Check if docker, docker cli, containerd.io, and docker-buildx-plugin are installed
if ! command -v docker &> /dev/null; then
    echo -e "${Red}Error code: 5 (Not installed)${NC}"
    echo -e "${Red}Install Docker and Docker-CLI before running ACS.${NC}"
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

# Install needed tools for installation script to work
echo -e "${Purple}Setting up ACS...${NC}"
echo -e "${Yellow}Run apt-get update${NC}"
sudo apt-get update > /dev/null 2>&1
echo -e "${Yellow}Run apt-get upgrade -y${NC}"
sudo apt-get upgrade -y > /dev/null 2>&1

# Check if docker images are downloaded
echo -e "${Purple}Downloading docker images${NC}"
images=("mikenye/youtube-dl" "plexinc/pms-docker" "lscr.io/linuxserver/jackett:latest" "lscr.io/linuxserver/radarr:latest" "lscr.io/linuxserver/sonarr:latest" "lscr.io/linuxserver/tautulli:latest" "lscr.io/linuxserver/deluge:latest" "lscr.io/linuxserver/ombi:latest") 
for image in "${images[@]}"; do
    if ! docker image inspect "$image" &> /dev/null; then
        echo -e "${Yellow}Downloading${NC} ${Blue}$image...${NC}"
        sudo docker pull "$image" > /dev/null 2>&1
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

sudo chmod 777 $MOVIES
sudo chmod 777 $SHOWS
sudo chmod 777 $MEDIA_DOWNLOAD
sudo chmod 777 $DOWNLOAD_COMPLETED

# Take user input and save it to a file
echo -e "${Purple}Enter the maximum number of containers to run for the youtube downloader${NC}"
echo -e "${Yellow}These containers are used to download videos${NC}"
read -p "Max Containers: " userInput
echo "$userInput" > $CONTAINER_MAX_FILE

sleep 2


echo -e "${Purple}Please choose an option:${NC}"
echo -e "1) Deploy only Plex"
echo -e "2) Deploy full system"
read -p "Enter your choice (1 or 2): " deployment_choice

case $deployment_choice in
    1)
        echo -e "${Purple}Setting up Plex only...${NC}"
        if ! sudo docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
            bash ~/ACS/ACSF-Scripts/setup-only-plex.sh
            echo -e "${Green}Plex setup completed${NC}"
        else
            echo -e "${Green}Plex docker is already running${NC}"
        fi

        ;;
    2)
        echo -e "${Purple}Setting up full system...${NC}"
        if ! sudo docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
            bash ~/ACS/ACSF-Scripts/setup-plex.sh
            echo -e "${Green}Plex setup completed${NC}"
        else
            echo -e "${Green}Plex docker is already running${NC}"
        fi
        ;;
    *)
        echo -e "${Red}Invalid option selected. Please enter 1 or 2.${NC}"
        ;;
esac



# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file

bash $ROOT_FOLDER/$ALIASES

# Add the cronjob
cron_job_exists() {
    local cron_command="$1"
    grep -qF "$cron_command" /etc/crontab
}

add_cron_job() {
    local cron_command="$1"
    echo "$cron_command" | sudo tee -a /etc/crontab >/dev/null
    echo "Cron job added: $cron_command"
}

# Check if cron jobs have already been added, if not, add them
automated_check_job="$CRON_TIMER root bash $ROOT_FOLDER/$AUTOMATED_CHECK"
reboot_job="45 4 * * * root /sbin/reboot"

if ! cron_job_exists "$automated_check_job"; then
    add_cron_job "$automated_check_job"
fi

if ! cron_job_exists "$reboot_job"; then
    add_cron_job "$reboot_job"
fi
echo -e "${Green}Cron job completed${NC}"

echo 
echo -e "${Green}Installation completed${NC}"
echo -e "${Yellow}In order for the custom commands to load run 'source ~/.bashrc'${NC}"
echo -e "${BrownOrange}Find all custom commands here https://runesrepohub.github.io/ACS/commands.html${NC}"