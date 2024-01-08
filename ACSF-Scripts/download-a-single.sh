#!/bin/bash
source ~/ACS/ACSF-Scripts/Core.sh

# Define the maximum number of running containers
max_containers=$(cat "$CONTAINER_MAX_FILE")

output_path="$YOUTUBE"

# Function to wait until the number of running containers is less than the maximum
wait_for_available_container() {
    while [ "$(docker ps | grep 'mikenye/youtube-dl' | wc -l)" -ge "$max_containers" ]; do
        sleep 60
    done
}

# Ask the user to enter the URL
read -p "Enter the URL: " url

# Exit if no URL is provided
[ -z "$url" ] && exit

# Record the start time of the script
start_time=$(date +%s)

# Check if the script has been running for more than 45 minutes (2700 seconds)
elapsed_time=$(( $(date +%s) - start_time ))
if [[ "$elapsed_time" -ge 2700 ]]; then
    echo "The script has been running for more than 45 minutes. Exiting."
    exit
fi

# Extract the video ID from the URL
video_id=$(echo "${url}" | awk -F '[=&]' '{print $2}')

# Get the playlist name using youtube-dl --get-filename
playlist_name=$(docker run --rm mikenye/youtube-dl --get-filename -o "%(playlist)s" "$url" | head -n 1)

# If the playlist name is not available, default to 'no_playlist'
playlist_name=${playlist_name:-no_playlist}

# Create the video folder if it doesn't exist
video_folder="${output_path}/${playlist_name}/"
if [ ! -d "${video_folder}" ]; then
    mkdir -p "${video_folder}"
fi
video_file="${video_folder}/${video_id}.mp4"

# Wait for available containers
wait_for_available_container

# Generate a unique container name based on the video ID 
container_name="${video_id}"

# Download video using docker run command in detached mode and delete the container when finished
docker run \
    --rm -d \
    -e PGID=$(id -g) \
    -e PUID=$(id -u) \
    -v "$MEDIA":/workdir:rw \
    -v "${video_folder}":/output:rw \
    --name "${container_name}" \
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
    --download-archive "download-archive.txt" \
    --output '/output/%(title)s.%(ext)s' \
    "${url}"

