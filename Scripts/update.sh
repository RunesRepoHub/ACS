#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Update update.sh
echo -e "$UPDATE_AUTO_YT_DL"
rm $ROOT_FOLDER/$DOWNLOAD
sleep 1
curl -s -o $ROOT_FOLDER/$DOWNLOAD $GIHUB_LINK/$GITHUB_FOLDER/$DOWNLOAD > /dev/null
echo -e "$UPDATE_AUTO_YT_DL_COMPLETED"

bash $ROOT_FOLDER/$DOWNLOAD