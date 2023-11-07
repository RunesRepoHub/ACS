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

# Read the URLs from the txt file
input_urls=$(cat ~/plex/media/url_file.txt)

output_path=~/plex/media/youtube

# Define the maximum number of running containers
max_containers=3
current_containers=0

# Loop over each URL from the txt file
while IFS= read -r url; do
    # Set the video file path
    video_folder="${output_path}/$(echo "${url}" | awk -F '=' '{print $2}')"
    video_file="${video_folder}/$(echo "${url}" | awk -F '=' '{print $2}').mp4"

    # Create the video folder if it doesn't exist
    mkdir -p "${video_folder}"

    # Check the number of running youtube-dl Docker containers
    while [ "$(docker ps | grep mikenye/youtube-dl | wc -l)" -ge "$max_containers" ]; do
        sleep 60
    done

    # Update the current number of running containers
    current_containers=$((current_containers+1))

    # Download video using docker run command in detached mode and delete the container when finished
    docker run \
        --rm -d \
        -e PGID=$(id -g) \
        -e PUID=$(id -u) \
        -v "$(pwd)":/workdir:rw \
        -v "${video_folder}":/output:rw \
        --name "$(echo "${url}" | awk -F '=' '{print $2}')" \
        --cpus 1 \
        --memory 2g \
        mikenye/youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' \
        --write-info-json \
        --write-thumbnail \
        --write-description \
        --write-sub \
        --embed-subs \
        --convert-subs srt \
        --write-auto-sub \
        --download-archive archive.txt \
        --output '/output/%(title)s.%(ext)s' \
        "${url}"

    # Decrement the current number of running containers
    current_containers=$((current_containers-1))
done < ~/plex/media/url_file.txt

