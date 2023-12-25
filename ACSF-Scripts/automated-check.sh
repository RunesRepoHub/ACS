#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Define the maximum number of running containers
max_containers=$(cat "$CONTAINER_MAX_FILE")

output_path="$YOUTUBE"

# Read the URLs from the txt file
input_urls=$(cat "$MEDIA/$ARCHIVE_URL_FILE")

total_lines=$(wc -l < "$MEDIA/$ARCHIVE_URL_FILE")

# Declare an array to store the video URLs
declare -a video_urls

# Loop over each URL from the txt file and store it in the video_urls array
while IFS= read -r url; do
    video_urls+=("$url")
done <<< "$input_urls"

# Function to wait until the number of running containers is less than the maximum
wait_for_available_container() {
    while [ "$(docker ps | grep 'mikenye/youtube-dl' | wc -l)" -ge "$max_containers" ]; do
        sleep 60
    done
}

# Record the start time of the script
start_time=$(date +%s)

# Loop over each video URL
while [ ${#video_urls[@]} -gt 0 ]; do
    # Check if it's between 4:20 AM and 5:25 AM, and if so, wait until it's not
    current_time=$(date +%H:%M)
    if [[ "$current_time" > "04:20" ]] && [[ "$current_time" < "05:25" ]]; then
        echo "It is between 4:20 AM and 5:25 AM. The script cannot continue during this time. Exiting."
        exit
    fi

    # Check if the script has been running for more than 10 hours (36000 seconds)
    elapsed_time=$(( $(date +%s) - start_time ))
    if [[ "$elapsed_time" -ge 36000 ]]; then
        echo "The script has been running for more than 10 hours. Exiting."
        exit
    fi

    # Set the video URL to download
    url="${video_urls[0]}"

    # Extract the video ID from the URL
    video_id=$(echo "${url}" | awk -F '[=&]' '{print $2}')

    # Set the video folder and file path
    video_folder="${output_path}/${video_id}"
    video_file="${video_folder}/${video_id}.mp4"

    # Check if the container with the same video ID is already running
    if docker ps --filter "name=${video_id}" --format '{{.Names}}' | grep -q "${video_id}"; then
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

    # Subtract 1 from the value of the total_lines
    total_lines=$((total_lines - 1))

    # Remove the processed URL from the array
    video_urls=("${video_urls[@]:1}")
done

