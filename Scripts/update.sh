#!/bin/bash

#############
### TO-DO ###
#############
### Change source to new repo name
### source ~/Auto-YT-DL/Scripts/Core.sh

#############
### TO-DO ###
#############
### Check paths
### Changes download link and methode 
### Download the whole repo and use git clone 

# Update update.sh
echo -e "$UPDATE_AUTO_YT_DL"
rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD $GIHUB_LINK/$GITHUB_FOLDER/$UPDATE_DOWNLOAD > /dev/null
echo -e "$UPDATE_AUTO_YT_DL_COMPLETED"

bash $ROOT_FOLDER/$UPDATE_DOWNLOAD