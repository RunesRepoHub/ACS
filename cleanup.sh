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

# Specify the parent folder path
parent_folder="~/plex/media/youtube"

# Create a directory to store the output files
output_folder="~/plex/media/youtube"
mkdir -p "$output_folder"

# Specify the blacklist file path
blacklist_file="~/plex/media/youtube/blacklist.txt"

# Iterate over the subfolders in the parent folder
for folder_path in "$parent_folder"/*; do
    # Get the folder name
    folder_name=$(basename "$folder_path")

    # Get the number of times each file has been accessed by plex
    access_count=$(grep -o "plex" /var/log/syslog | grep "$folder_path" | wc -l)

    # Check if the folder should be blacklisted
    if [ "$access_count" -gt 3 ]; then
        echo "$folder_name" >> "$blacklist_file"
    else
        # Create a text file for the folder and write the access count
        echo "The files in $folder_path have been accessed by plex $access_count times." > "$output_folder/$folder_name.txt"
    fi

    # Check if the file is not on the blacklist and is over 3 months old
    if ! grep -q "$folder_name" "$blacklist_file" && [ "$(find "$folder_path" -type f -mtime +"$days" | wc -l)" -gt 0 ]; then
        # Remove the file
        find "$folder_path" -type f -mtime +"$days" -exec rm {} \;
    fi
done

