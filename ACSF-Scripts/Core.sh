#############
### TO-DO ###
#############
### Update all paths to new repo name
### Modify text where needed
### Check all variables for errors and fix as needed and check if there is 2 of them, if there is delete one of them. But update all 
### scripts to the new variable.



##########################################################################
#####  Set variables for YT-Plex  # Core.sh # Made for @runesrepohub #####
########################## Made for @rune004 #############################
##########################################################################
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


### Admin Stuff # Setup.sh ###
#----------------------------#
# Make the Root folder
ROOT_FOLDER=~/ACS/Scripts
#----------------------------#


##########################################################################
#######  Set variables  # For Error codes # Made for @runesrepohub #######
##########################################################################

# Define error codes
SUCCESS="${Green}Error code: 0 (Success)${NC}"
INVALID_ARGUMENTS="${Yellow}Error code: 1 (Invalid arguments)${NC}"
FILE_NOT_FOUND="${Red}Error code: 2 (File not found)${NC}"
UNKNOWN_ERROR="${Red}Error code: 99 (Unknown error)${NC}"

##########################################################################
#########  Set variables  # For setup.sh # Made for @runesrepohub ########
##########################################################################
# Installer checks
# User checks before installation
# Reponses for user input
# Install


# Texts
REMOVING_OLD_SYSTEM_FILES="${Purple}Removing old system files for ACS and then downloading newest files...${NC}"
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
UPDATE_DOWNLOAD="download-update.sh"
SETUP_PLEX="setup-plex.sh"
DOWNLOAD="download.sh"
START="start.sh"
#--------------------------------------------------------------------------

# Make folders for ACS
YOUTUBE=~/plex/media/youtube 
TRANSCODE=~/plex/transcode 
LIBRARY=~/plex/library 
JACKETT=~/ACS/jackett 
RADARR=~/ACS/radarr 
MOVIES=~/plex/media/movies 
SONARR=~/ACS/sonarr 
SHOWS=~/plex/media/Shows 
MEDIA_DOWNLOAD=~/plex/media/download 
TAUTALLI=~/ACS/tautalli 
DELUGE=~/ACS/deluge 
OMBI=~/ACS/ombi  
DOWNLOAD_COMPLETED=~/plex/media/download/completed
#--------------------------------------------------------------------------

# Container max
CONTAINER_MAX_FILE=~/ACS/.max_containers
#--------------------------------------------------------------------------

# Cronjob
CRON_TIMER="0 0 30 * *"
#--------------------------------------------------------------------------

# Setup Plex
SETUP_PLEX_TEXT="${Purple}Making plex folders...${NC}"


##########################################################################
#####  Set variables  # For add-url-list.sh # Made for @runesrepohub #####
##########################################################################

# Folders and files
MEDIA=~/plex/media
URL_FILE="url_file.txt"
ARCHIVE_URL_FILE="archive_url_file.txt"

# Texts
URL_ALREADY_EXISTS="${Yellow}URL $url already exists, input another link instead${NC}"
ENTER_URL="${Green}Enter the Youtube Playlist URLs to add to the list:${NC}"

##########################################################################
# Set variables  # For docker-stop.sh + stop.sh # Made for @runesrepohub #
##########################################################################

YOUTUBE_DL_STOP="${Green}Stopping all mikenye/youtube-dl containers...${NC}"
YOUTUBE_DL_STOPPED="${Green}Stopped all mikenye/youtube-dl containers${NC}"
THIS_MAY_TAKE_A_WHILE="${Green}This may take a while...${NC}"
YOUTUBE_DL_STOPPING_TEXT="${Red}Stopping plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
YOUTUBE_DL_STOP_COMPLETED="${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"

##########################################################################
#####  Set variables  # For stop-remove.sh # Made for @runesrepohub ######
##########################################################################

YOUTUBE_DL_STOP_REMOVE_TEXT="${Red}Stopping any and all mikenye/youtube-dl dockers then delete them${NC}"
YOUTUBE_DL_STOP_REMOVE_COMPLETED="${Green}All mikenye/youtube-dl dockers have been stopped and removed${NC}"
DOCKER_STOP_REMOVE_TEXT="${Red}Stopping and removing plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
DOCKER_STOP_REMOVE_COMPLETED="${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi have been stopped and removed${NC}"
DOCKER_NETWORK_STOP_REMOVE="${Red}Removing the network my_plex_network${NC}"
DOCKER_NETWORK_STOP_REMOVE_COMPLETED="${Green}The network my_plex_network has been removed${NC}"

##########################################################################
######### Set variables  # For update.sh # Made for @runesrepohub ########
##########################################################################

UPDATE_AUTO_YT_DL="${Purple}Updating download-update.sh...${NC}"
UPDATE_AUTO_YT_DL_COMPLETED="${Green}Download-update.sh has been updated${NC}"

##########################################################################
######### Set variables  # For uninstall.sh # Made for @runesrepohub ########
##########################################################################

USER_TEXT_SAVE_PLEX="${Purple}Do you want to save all the files in the plex media folder or delete them?${NC}"
USER_ANSWER_SAVE_PLEX="${Green}y = Keep plex media folder${NC}"
USER_ANSWER_DELETE_PLEX="${Red}n = Delete plex media folder${NC}"

CLEANUP_ALL="${Purple}Cleanup all folders and files...${NC}"
CLEANUP_ALL_COMPLETED="${Green}All folders and files has been removed except the plex media folder, all dockers has been stopped${NC}"

CLEANUP_NOTPLEX="${Red}Stopping jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
CLEANUP_NOTPLEX_COMPLETED="${Green}All jackett, radarr, sonarr, tautulli, deluge and ombi dockers have been stopped${NC}"
CLEANUP_DONT_DELETE_PLEX="${Green}All folders and files has been removed except the plex media folder, all dockers has been stopped${NC}"

##########################################################################
###### Set variables  # For setup-plex.sh # Made for @runesrepohub #######
##########################################################################

DOCKER_NETWORK_ALREADY_EXIST="${Red}The network my_plex_network already exists${NC}"

DOCKER_CLAIM_PLEX_ALREADY="${Green}Plex is already running skipping plex claim${NC}"

DOCKER_CLAIM_PLEX_TEXT="${Green}Claim the Plex server${NC}"
DOCKER_CLAIM_PLEX_URL="${Green}https://www.plex.tv/claim/${NC}"
DOCKER_CLAIM_PLEX_HOSTNAME_TEXT="${Green}Enter the hostname that you want for the plex server in the plex settings${NC}"

DOCKER_ROOT_FOLDER=~/Auto-YT-DL
DOCKER_CONFIG_FOLDER="config"
DOCKER_PLEX_LIBRARY_FOLDER=~/plex/library
DOCKER_TRANSCODE_FOLDER=~/plex/transcode/temp
DOCKER_TRANSCODE_MOUNT="transcode"
DOCKER_PLEX_MEDIA=~/plex/media
DOCKER_PLEX_DATA="data"
DOCKER_PLEX_FOLDER="plex"
DOCKER_OMBI_FOLDER="ombi"
DOCKER_JACKETT_FOLDER="jackett"
DOCKER_RADARR_FOLDER="radarr"
DOCKER_SONARR_FOLDER="sonarr"
DOCKER_TAUTULLI_FOLDER="tautulli"
DOCKER_DELUGE_FOLDER="deluge"
DOCKER_DOWNLOAD_FOLDER=~/plex/media/download
DOCKER_MOUNT_DOWNLOAD_FOLDER="downloads"
DOCKER_HOST_SHOWS_FOLDER=~/plex/media/Shows
DOCKER_SHOWS_FOLDER="shows"
DOCKER_HOST_MOVIES_FOLDER=~/plex/media/movies
DOCKER_MOVIES_FOLDER="movies"

DOCKER_RESTART_ALWAYS="always"

##########################################################################
######### Set variables  # For start.sh # Made for @runesrepohub #########
##########################################################################

YOUTUBE_DL_START="${Purple}Starting any and all mikenye/youtube-dl dockers${NC}"
YOUTUBE_DL_START_COMPLETED="${Green}All mikenye/youtube-dl dockers have been started${NC}"
YOUTUBE_DL_STARTING_TEXT="${Red}Starting plex, jackett, radarr, sonarr, tautulli, deluge and ombi${NC}"
YOUTUBE_DL_STARTING_TEXT_COMPLETED="${Green}All plex, jackett, radarr, sonarr, tautulli, deluge and ombi have been started${NC}"
