# Set version (Prod or Dev)
Dev="Production"
export Dev=$Dev

# Update update.sh
echo -e "${Purple}Updating download-update.sh...${NC}"
rm ~/Auto-YT-DL/Scripts/download-update.sh
sleep 1
curl -s -o ~/Auto-YT-DL/Scripts/download-update.sh https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/$Dev/Scripts/download-update.sh > /dev/null
echo -e "${Green}download-update.sh has been updated.${NC}"

bash ~/Auto-YT-DL/Scripts/download-update.sh