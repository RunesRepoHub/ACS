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

# Check if folder ~/Auto-YT-DL/Scripts exists
if [ -d ~/Auto-YT-DL/Scripts ]; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}Folder ~/Auto-YT-DL/Scripts exists. Exiting script.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Check if docker, docker cli, containerd.io, and docker-buildx-plugin are installed
if ! command -v docker &> /dev/null; then
    echo -e "${Red}Error code: 404${NC}"
    echo -e "${Red}One or more dependencies are not installed.${NC}"
    echo -e "${Red}Aborting installation.${NC}"
    exit 1
fi

# Install needed tools for installation script to work
echo -e "${Purple}Setting up Auto-YT-DL...${NC}"

# Update and upgrade packages
echo -e "${Yellow}Run apt-get update and upgrade${NC}"
apt-get update -y > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1

# Install sudo if not already installed
if ! command -v sudo &> /dev/null; then
    echo -e "${Purple}Sudo is not installed.${NC}"
    echo -e "${Yellow}Installing sudo...${NC}"
    apt-get install sudo -y > /dev/null 2>&1
    echo -e "${Green}Sudo has been installed.${NC}"
else
    echo -e "${Green}Sudo is already installed.${NC}"
fi 

# Install curl if not already installed
if ! command -v curl &> /dev/null; then
    echo -e "${Purple}Curl is not installed.${NC}"
    echo -e "${Yellow}Installing curl...${NC}"
    apt-get install curl -y > /dev/null 2>&1
    echo -e "${Green}Curl has been installed.${NC}"
else
    echo -e "${Green}Curl is already installed.${NC}"
fi

# Make the folder
echo -e "${Purple}Make the folder ~/Auto-YT-DL${NC}"
mkdir -p ~/Auto-YT-DL/Scripts
echo -e "${Green}Folder created${NC}"



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

files=(
    "automated-check.sh"
    "add-url.sh"
    "setup-plex.sh"
    "download.sh"
    "docker-stop.sh"
    "docker-compose.yml"
    "stop.sh"
    "uninstall.sh"
    "stop-remove.sh"
    "update.sh"
    "add-url-list.sh"
)

for file in "${files[@]}"; do
    if [ -e "~/Auto-YT-DL/Scripts/$file" ]; then
        rm "~/Auto-YT-DL/Scripts/$file"
    fi
    sleep 1
    curl -s -o "~/Auto-YT-DL/Scripts/$file" "https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/$file" > /dev/null
done

echo -e "${Green}Downloading files complete${NC}"

sleep 2

# Check if ~/plex/media, ~/plex/transcode, and ~/plex/plex/database exist
echo -e "${Purple}Making folders for plex. media, transcode, and library...${NC}"
folders=(
    "~/plex/media/youtube"
    "~/plex/transcode"
    "~/plex/library"
    "~/Auto-YT-DL/jackett"
    "~/Auto-YT-DL/radarr"
    "~/plex/media/movies"
    "~/Auto-YT-DL/sonarr"
    "~/plex/media/Shows"
    "~/plex/media/download"
    "~/Auto-YT-DL/tautalli"
    "~/Auto-YT-DL/deluge"
    "~/Auto-YT-DL/ombi"
    "~/plex/media/download/completed"
)

for folder in "${folders[@]}"; do
    if [ ! -d "$folder" ]; then
        mkdir -p "$folder"
    fi
done

if [ -z "$(ls -A ~/plex/media/youtube)" ] || [ -z "$(ls -A ~/plex/transcode)" ] || [ -z "$(ls -A ~/plex/library)" ] || [ -z "$(ls -A ~/Auto-YT-DL/jackett)" ] || [ -z "$(ls -A ~/Auto-YT-DL/radarr)" ] || [ -z "$(ls -A ~/plex/media/movies)" ] || [ -z "$(ls -A ~/Auto-YT-DL/sonarr)" ] || [ -z "$(ls -A ~/plex/media/Shows)" ] || [ -z "$(ls -A ~/plex/media/download)" ] || [ -z "$(ls -A ~/Auto-YT-DL/tautalli)" ] || [ -z "$(ls -A ~/Auto-YT-DL/deluge)" ] || [ -z "$(ls -A ~/Auto-YT-DL/ombi)" ] || [ -z "$(ls -A ~/plex/media/download/completed)" ]; then
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