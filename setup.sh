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

# Start clean
clear 

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}Docker is not installed.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if docker cli is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}Docker CLI is not installed.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if containerd.io is installed
if ! command -v containerd &> /dev/null; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}Containerd is not installed.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if docker-buildx-plugin
if ! command -v docker-buildx-plugin &> /dev/null; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}Docker-buildx-plugin is not installed.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

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
mkdir -p ~/Auto-YT-DL/Scripts

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

if [ -e ~/Auto-YT-DL/Scripts/automated-check.sh ]; then
    rm ~/Auto-YT-DL/Scripts/automated-check.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/automated-check.sh https://raw.githubusercontent.com/RunesRepoHub/Scripts/YT-Plex/$Dev/automated-check.sh > /dev/null

if [ -e ~/Auto-YT-DL/Scripts/add-url.sh ]; then
    rm ~/Auto-YT-DL/Scripts/add-url.sh
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/add-url.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/add-url.sh > /dev/null

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

if [ -e ~/Auto-YT-DL/Scripts/docker-compose.yml ]; then
    rm ~/Auto-YT-DL/Scripts/docker-compose.yml
fi
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/docker-compose.yml https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/docker-compose.yml > /dev/null

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

echo -e "${Green}Downloading files complete${NC}"

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
if [ ! -d ~/plex/media/youtube ] || [ ! -d ~/plex/transcode ] || [ ! -d ~/plex/library ] || [ ! -d ~/Auto-YT-DL/jackett ] || [ ! -d ~/Auto-YT-DL/radarr ] || [ ! -d ~/plex/media/movies ] || [ ! -d ~/sonarr ] || [ ! -d ~/plex/media/Shows ] || [ ! -d ~/plex/media/download ] || [ ! -d ~/Auto-YT-DL/tautalli ] || [ ! -d ~/Auto-YT-DL/deluge ] || [ ! -d ~/Auto-YT-DL/ombi ] || [ ! -d ~/plex/media/download/completed ]; then
    # Create the folders if they don't exist
    mkdir -p ~/plex/media/youtube ~/plex/transcode ~/plex/library ~/Auto-YT-DL/jackett ~/Auto-YT-DL/radarr ~/plex/media/movies ~/Auto-YT-DL/sonarr ~/plex/media/Shows ~/plex/media/download ~/Auto-YT-DL/tautalli ~/Auto-YT-DL/deluge ~/Auto-YT-DL/ombi  ~/plex/media/download/completed
else
    echo -e "${Red}Error code: 302${NC}"
    echo -e "${Red}Folders already exist${NC}"
    echo -e "${Red}The installation might fail due to this error${NC}"
fi

chmod 777 ~/plex/media/movies/
chmod 777 ~/plex/media/Shows/
chmod 777 ~/plex/media/download/
chmod 777 ~/plex/media/download/completed

# Take user input and save it to a file
echo -e "${Purple}Enter the maximum number of containers to run for the youtube downloader${NC}"
echo -e "${Purple}These containers are used to download videos${NC}"
read -p "Max Containers: " userInput
echo "$userInput" > ~/Auto-YT-DL/.max_containers

# Add the first url
if [ ! -f ~/plex/media/url_file.txt ]; then
    bash ~/Auto-YT-DL/Scripts/add-url.sh
fi

sleep 2

# Setup plex
echo -e "${Purple}Setting up plex...${NC}"
if ! docker ps --filter "name=plex" --format '{{.Names}}' | grep -q "plex"; then
    bash ~/Auto-YT-DL/Scripts//Auto-YT-DLsetup-plex.sh
else
    echo -e "${Green}Plex docker is already running${NC}"
fi

# Add alias
echo -e "${Purple}Setup cronjob and alias${NC}"
# Add aliases to the shell configuration file
echo 'alias add-url="bash ~/Auto-YT-DL/Scripts/add-url.sh"' >> ~/.bashrc
echo 'alias add-url="bash ~/Auto-YT-DL/Scripts/add-url-list.sh"' >> ~/.bashrc
echo 'alias get-overview="docker ps --filter '\''ancestor=mikenye/youtube-dl'\''"' >> ~/.bashrc
echo 'alias start-download="bash ~/Auto-YT-DL/Scripts/automated-check.sh"' >> ~/.bashrc
echo 'alias stop-download="bash ~/Auto-YT-DL/Scripts/docker-stop.sh"' >> ~/.bashrc
echo 'alias stop-all="bash ~/Auto-YT-DL/Scripts/stop.sh"' >> ~/.bashrc
echo 'alias yt-uninstall="bash ~/Auto-YT-DL/Scripts/uninstall.sh"' >> ~/.bashrc
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