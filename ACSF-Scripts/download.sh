#!/bin/bash

LOG_DIR="$HOME/ACS/logs"
# Configuration
LOG_FILE="$LOG_DIR/download_script.log"  # Log file location

# Function to increment log file name
increment_log_file_name() {
  local log_file_base_name="download_script_run_"
  local log_file_extension=".log"
  local log_file_counter=1

  while [[ -f "$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}" ]]; do
    ((log_file_counter++))
  done

  LOG_FILE="$LOG_DIR/${log_file_base_name}${log_file_counter}${log_file_extension}"
  echo "Log file will be saved as $LOG_FILE"
}

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Increment log file name for this run
increment_log_file_name

# Redirect all output to the log file
exec > >(tee -a "$LOG_FILE") 2>&1

source ~/ACS/ACSF-Scripts/Core.sh

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
    # Check if the script has been running for more than 45 minutes (2700 seconds)
    elapsed_time=$(( $(date +%s) - start_time ))
    if [[ "$elapsed_time" -ge 2700 ]]; then
        echo "The script has been running for more than 45 minutes. Exiting."
        exit
    fi

    # Calculate progress as a percentage of the 45-minute limit
    progress=$((elapsed_time * 100 / 2700))

    # Print a condensed progress bar
    printf -v bar "[%-${progress}s]"
    echo -ne "Progress: $progress% ${bar:0:10}\r"
    echo

    # Set the video URL to download
    url="${video_urls[0]}"

    # Extract the video ID from the URL
    video_id=$(echo "${url}" | awk -F '[=&]' '{print $2}')

    # Get the channel name using youtube-dl --get-filename
    channel_name=$(docker run --rm mikenye/youtube-dl --get-filename -o "%(channel)s" "$url" | head -n 1)
    
    # Get the playlist name using youtube-dl --get-filename
    playlist_name=$(docker run --rm mikenye/youtube-dl --get-filename -o "%(playlist)s" "$url" | head -n 1)
    
    # If the playlist name is not available, default to 'no_playlist'
    playlist_name=${playlist_name:-no_playlist}
    
    # Create the video folder if it doesn't exist
    video_folder="${output_path}/${channel_name}/${playlist_name}/"
    video_file="${video_folder}/${video_id}.mp4"

    # Create the video folder if it doesn't exist
    if [ ! -d "${video_folder}" ]; then
        mkdir -p "${video_folder}"
    fi

    # Check if the container with the same video ID is already running
    if docker ps --filter "name=${video_id}" --format '{{.Names}}' | grep -q "${video_id}"; then
        # Remove the processed URL from the array
        video_urls=("${video_urls[@]:1}")
        continue
    fi

    if [ "$total_lines" -eq 0 ]; then
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

