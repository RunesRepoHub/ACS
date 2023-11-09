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