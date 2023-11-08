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
Dev="Production"
export Dev=$Dev

# Install needed tools for installation script to work
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"
echo -e "${Yellow}Run apt-get update${NC}"
apt-get update > /dev/null 2>&1
echo -e "${Yellow}Run apt-get upgrade -y${NC}"
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
echo -e "${Purple}Make the folder ~/Auto-YT-DL${NC}"
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


if [ -e ~/Auto-YT-DL/docker-stop.sh ]; then
    rm ~/Auto-YT-DL/docker-stop.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/docker-stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/docker-stop.sh > /dev/null

if [ -e ~/Auto-YT-DL/docker-compose.yml ]; then
    rm ~/Auto-YT-DL/docker-compose.yml
fi
sleep 1
curl -s -o ~/Auto-YT-DL/docker-compose.yml https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/docker-compose.yml > /dev/null

if [ -e ~/Auto-YT-DL/stop.sh ]; then
    rm ~/Auto-YT-DL/stop.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/stop.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/stop.sh > /dev/null

if [ -e ~/Auto-YT-DL/uninstall.sh ]; then
    rm ~/Auto-YT-DL/uninstall.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/uninstall.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/uninstall.sh > /dev/null

if [ -e ~/Auto-YT-DL/stop-remove.sh ]; then
    rm ~/Auto-YT-DL/stop-remove.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/stop-remove.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/stop-remove.sh > /dev/null

echo -e "${Green}Downloading files complete${NC}"

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ] || [ ! -d ~/jackett ] || [ ! -d ~/radarr ] || [ ! -d ~/plex/media/movies ] || [ ! -d ~/sonarr ] || [ ! -d ~/plex/media/Shows ] || [ ! -d ~/download/downloading_completed ] || [ ! -d ~/tautalli ] || [ ! -d ~/deluge ] || [ ! -d ~/ombi ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library ~/jackett ~/radarr ~/plex/media/movies ~/sonarr ~/plex/media/Shows ~/download/downloading_completed ~/tautalli ~/deluge ~/ombi
else
    echo -e "${Red}Error code: 302${NC}"
    echo -e "${Red}Folders already exist${NC}"
    echo -e "${Red}The installation might fail due to this error${NC}"
fi

chmod 777 ~/plex/media/movies/
chmod 777 ~/plex/media/Shows/
chmod 777 ~/plex/media/download/

# Add the first url
bash ~/Auto-YT-DL/add-url.sh

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
if ! docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
    bash ~/Auto-YT-DL/setup-plex.sh
else
    echo -e "${Green}Plex docker is already running${NC}"
fi

# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file
echo 'alias add-url="bash ~/Auto-YT-DL/add-url.sh"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias start-download="bash ~/Auto-YT-DL/automated-check.sh"' >> ~/.bashrc
echo 'alias stop-download="bash ~/Auto-YT-DL/docker-stop.sh"' >> ~/.bashrc
echo 'alias stop-all="bash ~/Auto-YT-DL/stop.sh"' >> ~/.bashrc
echo 'alias yt-uninstall="bash ~/Auto-YT-DL/uninstall.sh"' >> ~/.bashrc
echo 'alias remove-all="bash ~/Auto-YT-DL/stop-remove.sh"' >> ~/.bashrc


alias remove-all="bash ~/Auto-YT-DL/stop-remove.sh"
alias yt-uninstall="bash ~/Auto-YT-DL/uninstall.sh"
alias stop-all="bash ~/Auto-YT-DL/stop.sh"
alias get-overview="docker ps --filter 'ancestor=mikenye/youtube-dl'"
alias stop-download="bash ~/Auto-YT-DL/docker-stop.sh"
alias start-download="bash ~/Auto-YT-DL/automated-check.sh"
alias add-url="bash ~/Auto-YT-DL/add-url.sh"
# Load the updated shell configuration file
source ~/.bashrc


# Add the cronjob
echo "0 0 30 * * root bash ~/Auto-YT-DL/automated-check.sh" | sudo tee -a /etc/crontab >/dev/null
echo -e "${Green}Cron job added successfully.${NC}"

sleep 2 
# Remove files
rm ~/Auto-YT-DL/setup-plex.sh

echo -e "${Green}Done!${NC}"