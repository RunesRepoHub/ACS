
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

##########################################################################
#######  Set variables  # For Error codes # Made by @runesrepohub ########
##########################################################################

# Define error codes
SUCCESS="${Green}Error code: 0 (Success)${NC}"
INVALID_ARGUMENTS="${Yellow}Error code: 1 (Invalid arguments)${NC}"
FILE_NOT_FOUND="${Red}Error code: 2 (File not found)${NC}"
FILE_ALREADY_EXISTS="${Red}Error code: 3 (File already exists)${NC}"
PERMISSION_DENIED="${Red}Error code: 4 (Permission denied)${NC}"
NOT_INSTALLED="${Red}Error code: 5 (Not installed)${NC}"
UNKNOWN_ERROR="${Red}Error code: 99 (Unknown error)${NC}"

##########################################################################
#########  Set variables  # For setup.sh # Made by @runesrepohub #########
##########################################################################
# Installer checks
# User checks before installation
# Reponses for user input
# Install
ABORT_INSTALL="${Red}Aborting installation.${NC}"
INSTALL_SUCCESSFUL="${Green}Installation successful.${NC}"
INSTALL_FAILED="${Red}Installation failed.${NC}"
INSTALL_MIGHT_FAIL="${Red}The installation might fail due to this error${NC}"
INSTALL_COMPLETED="${Green}Installation completed${NC}"
# Custom Commands
CUSTOM_COMMANDS="${Yellow}In order for the custom commands to load run 'source ~/.bashrc'${NC}"
CUSTOM_COMMANDS_HELP="${Orange}Find all custom commands here https://runesrepohub.github.io/YT-Plex/commands.html${NC}"
# Folders
FOLDER_CREATED="${Green}Folder created${NC}"
FOLDERS_CREATED="${Green}Folders created${NC}"
FOLDERS_EXISTS="${Red}Folders already exist.${NC}"
# Root user check
MUST_BE_ROOT="${Red}Must be root to run this.${NC}"
# Docker check
INSTALLATION_NEEDED="${Red}Install Docker and Docker-CLI before running Auto-YT-DL.${NC}"
#--------------------------------------------------------------------------

# Setting up Auto-YT-DL
SETTING_UP_AUTO="${Purple}Setting up Auto-YT-DL...${NC}"
RUN_UPDATE="${Yellow}Run apt-get update${NC}"
RUN_UPGRADE="${Yellow}Run apt-get upgrade -y${NC}"
#--------------------------------------------------------------------------

# Check if sudo is installed, if nor install it.
CHECK_SUDO="${Purple}Check if sudo is installed${NC}"
SUDO_INSTALLED="${Green}Sudo has been installed${NC}"
SUDO_NOT_INSTALLED="${Red}Sudo is not installed.${NC}"
SUDO_IS_ALREADY_INSTALLED="${Green}Sudo is already installed.${NC}"
SUDO_INSTALLING="${Yellow}Installing sudo...${NC}"
#--------------------------------------------------------------------------

# Check if curl is installed, if nor install it.
CHECK_CURL="${Purple}Check if curl is installed${NC}"
CURL_INSTALLED="${Green}Curl has been installed${NC}"
CURL_NOT_INSTALLED="${Red}Curl is not installed.${NC}"
CURL_IS_ALREADY_INSTALLED="${Green}Curl is already installed.${NC}"
CURL_INSTALLING="${Yellow}Installing curl...${NC}"
#--------------------------------------------------------------------------

# Download docker images
DOWNLOADING_DOCKER_IMAGES="${Purple}Downloading docker images${NC}"
DOCKER_IMAGES_DOWNLOADING="${Yellow}Downloading${NC}"
DOCKER_IMAGES_DOWNLOADED="${Green}has been downloaded.${NC}"
DOCKER_IMAGES_FOUND="${Green}is already downloaded.${NC}"
#--------------------------------------------------------------------------

# Make the Root folder
ROOT_FOLDER=~/Auto-YT-DL/Scripts
ALREADY_EXISTS_ROOT="${Red}Folder ~/Auto-YT-DL/Scripts already exists.${NC}"
MAKE_ROOT_FOLDER="${Purple}Make the folder ~/Auto-YT-DL${NC}"
#--------------------------------------------------------------------------

# Download other scripts
# Github repo link
GIHUB_LINK="https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Dev"
GITHUB_FOLDER="Scripts"
#--------------------------------------------------------------------------
# Texts
REMOVING_OLD_SYSTEM_FILES="${Purple}Removing old system files for Auto-YT-DL and then downloading newest files...${NC}"
DOWNLOADING_NEW_FILES="${Green}Downloading new files complete${NC}"
#--------------------------------------------------------------------------

# All script names + file format
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
#--------------------------------------------------------------------------

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
#--------------------------------------------------------------------------

# Container max
CONTAINER_MAX_TEXT="${Purple}Enter the maximum number of containers to run for the youtube downloader${NC}"
CONTAINER_INFO="${Yellow}These containers are used to download videos${NC}"
CONTAINER_MAX_FILE=~/Auto-YT-DL/.max_containers
#--------------------------------------------------------------------------

# Cronjob
CRONJOB_TEXT="${Purple}Setup cronjob and alias${NC}"
CRON_TIMER="0 0 30 * *"
CRON_COMPLETED="${Green}Cron job completed${NC}"
#--------------------------------------------------------------------------

# Setup Plex
SETUP_PLEX_TEXT="${Purple}Making plex folders...${NC}"
SETUP_PLEX_COMPLETED="${Green}Setup plex completed${NC}"
SETUP_PLEX_FAILED="${Green}Plex docker is already running${NC}"
MAKE_PLEX_FOLDERS="${Purple}Making folders for plex. media, transcode, and library...${NC}"

##########################################################################
#########  Set variables  # For ******** # Made by @runesrepohub #########
##########################################################################