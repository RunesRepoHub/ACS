#!/bin/bash

echo "Do you want to save all the files in the plex media folder or delete them?"
echo "y = Keep plex media folder"
echo "n = Delete plex media folder"

# Prompt the user for a yes/no answer
read -p "Are you sure? (y/n): " answer

# Check the user's response
if [[ $answer == "y" ]]; then
    # User answered "yes"
    # run docker stop all
    bash ~/Auto-YT-DL/stop.sh
    sleep 2
    # remove all folders and files
    rm -rf ~/Auto-YT-DL  ~/deluge  ~/download  ~/jackett  ~/ombi  ~/radarr  ~/sonarr  ~/tautalli
    echo -e "All folders and files has been removed except the plex media folder, all dockers has been stopped"
    
elif [[ $answer == "n" ]]; then
    # User answered "no"
    # run docker stop all
    bash ~/Auto-YT-DL/stop.sh
    sleep 2
    # remove all folders and files
    rm -rf ~/Auto-YT-DL  ~/deluge  ~/download  ~/jackett  ~/ombi  ~/plex  ~/radarr  ~/sonarr  ~/tautalli
    echo -e "All folders and files has been removed, all dockers has been stopped"
else
    # User entered an invalid response
    echo "Invalid input!"
fi

