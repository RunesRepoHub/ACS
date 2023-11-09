echo -e "${Green}Enter the Youtube Playlist URLs to add to the list:${NC}"
# Prompt the user to enter the URLs
read -p "Enter the URLs (separated by space): " input_urls

# Check if the file exists, and if not, create it
if [ ! -f ~/plex/media/url_file.txt ]; then
    touch ~/plex/media/url_file.txt
fi

# Read the existing URLs from the file
existing_urls=$(cat ~/plex/media/url_file.txt)

# Loop over each URL entered by the user
for url in $input_urls; do
    # Check if the URL already exists in the file
    if grep -Fxq "$url" ~/plex/media/url_file.txt; then
        echo -e "${Yellow}URL $url already exists, input another link instead${NC}"
        bash ~/Auto-YT-DL/Scripts/add-url-list.sh
    else
        # Append the new URL to the file
        echo "$url" >> ~/plex/media/url_file.txt
        bash ~/Auto-YT-DL/Scripts/download.sh
    fi
done

