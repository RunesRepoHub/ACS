#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Define the maximum number of running containers
max_containers=$(cat $CONTAINER_MAX_FILE)

output_path="$YOUTUBE"

# Read the URLs from the txt file
input_urls=$(cat $MEDIA/$ARCHIVE_URL_FILE)

total_lines=$(wc -l < $MEDIA/$ARCHIVE_URL_FILE)

# Declare an array to store the video URLs
declare -a video_urls

# Loop over each URL from the txt file and store it in the video_urls array
while IFS= read -r url; do
    video_urls+=("$url")
done <<< "$input_urls"

# Function to wait until the number of running containers is less than the maximum
wait_for_available_container() {
    while [ "$(docker ps | grep mikenye/youtube-dl | wc -l)" -ge "$max_containers" ]; do
        sleep 60
    done
}

# Loop over each video URL
while [ ${#video_urls[@]} -gt 0 ]; do
    # Set the video URL to download
    url="${video_urls[0]}"

    # Set the video file path
    video_folder="${output_path}/$(echo "${url}" | awk -F '=' '{print $2}')"
    video_file="${video_folder}/$(echo "${url}" | awk -F '=' '{print $2}').mp4"

    # Create the video folder if it doesn't exist
    if [ -d "${video_folder}" ]; then
        exit
    fi
    mkdir -p "${video_folder}"

    # Get the hostname from the URL
    hostname=$(echo "${url}" | awk -F '=' '{print $2}')

    # Check if the container with the same hostname is already running
    if [ "$(docker ps --filter "name=${hostname}" --format '{{.Names}}')" ]; then
        # Remove the processed URL from the array
        video_urls=("${video_urls[@]:1}")
        continue
    fi

    if [ $total_lines -eq 0 ]; then
        exit
    fi

    # Wait for Docker to spin up
    sleep 5

    # Wait for available containers
    wait_for_available_container

    # Generate a unique container name based on the URL 
    container_name="$(echo "${url}" | awk -F '=' '{print $2}')"

    # Download video using docker run command in detached mode and delete the container when finished
    docker run \
        --rm -d \
        -e PGID=$(id -g) \
        -e PUID=$(id -u) \
        -v "$(pwd)":/workdir:rw \
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
        --download-archive /Auto-YT-DL/archive.txt \
        --output '/output/%(title)s.%(ext)s' \
        "${url}"

    # Subtract 1 from the value of the variable total_lines
    total_lines=$((total_lines - 1))

    # Remove the processed URL from the array
    video_urls=("${video_urls[@]:1}")
done