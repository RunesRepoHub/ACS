#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Update update.sh
echo -e "$UPDATE_AUTO_YT_DL"
rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/Scripts/download-update.sh > /dev/null
echo -e "$UPDATE_AUTO_YT_DL_COMPLETED"

bash $ROOT_FOLDER/$UPDATE_DOWNLOAD