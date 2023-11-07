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

# Install needed tools for installation script to work
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"
echo -e "${Purple}Run apt-get update${NC}"
apt-get update > /dev/null 2>&1
echo -e "${Purple}Run apt-get upgrade -y${NC}"
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

# Make the folder
echo -e "${Yellow}Make the folder ~/Auto-YT-DL${NC}"
mkdir -p ~/Auto-YT-DL/

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
images=("mikenye/youtube-dl" "plexinc/pms-docker")
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

# Download files
echo -e "${Purple}Removing old system files for Auto-YT-DL and then downloading newest files...${NC}"

if [ -e ~/Auto-YT-DL/automated-check.sh ]; then
    rm ~/Auto-YT-DL/automated-check.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/automated-check.sh > /dev/null

if [ -e ~/Auto-YT-DL/add-url.sh ]; then
    rm ~/Auto-YT-DL/add-url.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/add-url.sh > /dev/null

if [ -e ~/Auto-YT-DL/setup-plex.sh ]; then
    rm ~/Auto-YT-DL/setup-plex.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/setup-plex.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/setup-plex.sh > /dev/null

if [ -e ~/Auto-YT-DL/download.sh ]; then
    rm ~/Auto-YT-DL/download.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/download.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/download.sh > /dev/null
echo -e "${Green}Downloading files complete${NC}"

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library
    else
    echo -e "${Red}Error code: 302${NC}"
    echo -e "${Red}Folders already exist${NC}"
    echo -e "${Red}The installation might fail due to this error${NC}"
fi

# Add the first url
bash ~/Auto-YT-DL/add-url.sh

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
bash ~/Auto-YT-DL/setup-plex.sh

# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file
echo 'alias add-url="bash ~/Auto-YT-DL/add-url.sh"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias trigger-download="bash ~/Auto-YT-DL/automated-check.sh"' >> ~/.bashrc

# Load the updated shell configuration file
source ~/.bashrc

# Add cronjob
if ! crontab -l | grep "0 0 30 \* \* root bash ~/Auto-YT-DL/automated-check.sh" >/dev/null 2>&1; then
    echo "0 0 30 * * root bash ~/Auto-YT-DL/automated-check.sh" | sudo tee -a /etc/crontab >/dev/null
    echo -e "${Green}Cron job added successfully.${NC}"
else
    echo -e "${Red}Cron job already exists.${NC}"
fi

sleep 2 
# Remove files
rm ~/Auto-YT-DL/setup-plex.sh

echo -e "${Green}Done!${NC}"