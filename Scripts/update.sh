#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Update update.sh
echo -e "$UPDATE_AUTO_YT_DL"
rm $ROOT_FOLDER/$UPDATE
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE $GIHUB_LINK/$GITHUB_FOLDER/$UPDATE > /dev/null
echo -e "$UPDATE_AUTO_YT_DL_COMPLETED"

bash $ROOT_FOLDER/$UPDATE