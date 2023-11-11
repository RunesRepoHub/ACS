source ~/Auto-YT-DL/Scripts/Core.sh

echo -e "$ENTER_URL"
# Prompt the user to enter the URLs
read -p "Enter the URLs (separated by space): " input_urls

# Check if the file exists, and if not, create it
if [ ! -f $MEDIA/$URL_FILE ]; then
    touch $MEDIA/$URL_FILE
fi

if [ ! -f $MEDIA/$ARCHIVE_URL_FILE ]; then
    touch $MEDIA/$ARCHIVE_URL_FILE
fi

# Read the existing URLs from the file
existing_urls=$(cat $MEDIA/$URL_FILE)

# Loop over each URL entered by the user
for url in $input_urls; do
    # Check if the URL already exists in the file
    if grep -Fxq "$url" $MEDIA/$URL_FILE; then
        echo -e "$URL_ALREADY_EXISTS"
        bash $ROOT_FOLDER/$ADD_URL_LIST
    else
        # Append the new URL to the file
        echo "$url" > $MEDIA/$URL_FILE
        echo "$url" >> $MEDIA/$ARCHIVE_URL_FILE
        bash $ROOT_FOLDER/$DOWNLOAD
    fi
done

