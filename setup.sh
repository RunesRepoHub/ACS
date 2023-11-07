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

# Set version (Prod or Dev)
Dev="Dev"
export Dev=$Dev

# Make the folder
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"
echo -e "${Yellow}Make the folder ~/Auto-YT-DL${NC}"
mkdir -p ~/Auto-YT-DL/

echo -e "${Purple}Check if curl is installed${NC}"
# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo -e "${Purple}Curl is not installed.${NC}"
    echo -e "${Yellow}Installing curl...${NC}"
    sudo apt-get install curl -y
    echo -e "${Green}Curl has been installed.${NC}"
else
    echo -e "${Green}Curl is already installed.${NC}"
fi

echo -e "${Purple}Check if docker and docker-compose is installed${NC}"
# Check if docker and docker-compose are installed
if ! command -v docker &> /dev/null; then
    echo -e "${Purple}Docker is not installed.${NC}"
    echo -e "${Yellow}Installing docker...${NC}"
    curl -s -o ~/Auto-YT-DL/docker.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/docker.sh > /dev/null
    bash ~/Auto-YT-DL/docker.sh
    echo -e "${Green}Docker has been installed.${NC}"
else
    echo -e "${Green}Docker is already installed.${NC}"
fi

# Check if docker image is downloaded
echo -e "${Purple}Check if docker image is downloaded${NC}"
if ! docker image inspect mikenye/youtube-dl &> /dev/null; then
    echo -e "${Purple}Docker image is not downloaded.${NC}"
    echo -e "${Yellow}Downloading docker image...${NC}"
    docker pull mikenye/youtube-dl
    echo -e "${Green}Docker image has been downloaded.${NC}"
else
    echo -e "${Green}Docker image is already downloaded.${NC}"
fi

sleep 2

echo -e "${Purple}Downloading files...${NC}"

curl -s -o ~/Auto-YT-DL/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/automated-check.sh > /dev/null

curl -s -o ~/Auto-YT-DL/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/add-url.sh > /dev/null

curl -s -o ~/Auto-YT-DL/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/setup-plex.sh > /dev/null

curl -s -o ~/Auto-YT-DL/download.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/download.sh > /dev/null

echo -e "${Green}Downloading files complete${NC}"

sleep 2

echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library
    else
    echo -e "${Red}Error code: 302${NC}"
    echo -e "${Red}Folders already exist${NC}"
    echo -e "${Red}If you want this script to work,then delete the folders ~/plex/media/youtube, ~/plex/transcode, and ~/plex/library${NC}"
    break 2
fi

bash ~/Auto-YT-DL/add-url.sh

sleep 2

echo -e "${Purple}Setting up plex...${NC}"

bash ~/Auto-YT-DL/setup-plex.sh


echo -e "${Purple}Setup cronjob and alias${NC}"

alias add-url="bash ~/Auto-YT-DL/add-url.sh"

if ! crontab -l | grep "0 0 30 \* \* root bash ~/Auto-YT-DL/automated-check.sh" >/dev/null 2>&1; then
    echo "0 0 30 * * root bash ~/Auto-YT-DL/automated-check.sh" | sudo tee -a /etc/crontab >/dev/null
    echo -e "${Green}Cron job added successfully.${NC}"
else
    echo -e "${Red}Cron job already exists.${NC}"
fi

sleep 2 

echo -e "${Green}Done!${NC}"

rm ~/Auto-YT-DL/setup-plex.sh