#!/bin/bash

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

echo -e "${Green}Enter the Youtube Playlist URL to add to the list:${NC}"
# Prompt the user to enter the URLs
read -p "Enter the URL: " input_urls

# Check if the file exists, and if not, create it
if [ ! -f ~/plex/media/url_file.txt ]; then
    touch ~/plex/media/url_file.txt
fi

# Read the existing URLs from the file
existing_urls=$(cat ~/plex/media/url_file.txt)

# Loop over each URL entered by the user
for url in $input_urls; do
    # Check if the URL already exists in the file
    if [[ $existing_urls =~ (^|[[:space:]])$url($|[[:space:]]) ]]; then
        echo -e "${Yellow}URL $url already exists, skipping...${NC}"
    else
        # Append the new URL to the file
        echo "$url" >> ~/plex/media/url_file.txt
        echo "$url" > ~/plex/media/.url
    fi
done

bash ~/Auto-YT-DL/download.sh
