#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Usage: ./convert-webm-to-mp4.sh /path/to/directory

# Check for ffmpeg installation and install if not found
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg could not be found, installing now..."
    # Assuming a Debian-based system
    sudo apt-get update && sudo apt-get install -y ffmpeg
else
    echo "ffmpeg is already installed."
fi

# Check if the path is provided
if [ -z "$1" ]; then
    echo "Please provide a path to scan for webm files."
    exit 1
fi

# Assign the path to a variable
SEARCH_PATH="$1"

# Limit to 4GB of RAM and 2 cores
ulimit -v $((4*1024*1024))
taskset -c 0,1

# Start a background process that will kill this script after 1 hour
( sleep 3600 && kill $$ ) &

# Find all webm files in the given path and its subfolders
find "$SEARCH_PATH" -type f -name "*.webm" | while read -r webm_file; do
    # Convert webm to mp4 using ffmpeg
    mp4_file="${webm_file%.*}.mp4"
    ffmpeg -i "$webm_file" -c:v libx264 -c:a aac -strict experimental "$mp4_file" < /dev/null

    # Check if the conversion was successful
    if [ $? -eq 0 ]; then
        # Delete the original webm file
        rm "$webm_file"
    else
        echo "Failed to convert $webm_file"
    fi
done
