#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

#############
### TO-DO ###
#############
### Check paths
### Changes download link and methode 
### Download the whole repo and use git clone 

# Update update.sh
echo -e "${Purple}Updating download-update.sh...${NC}"
rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD $GIHUB_LINK/$GITHUB_FOLDER/$UPDATE_DOWNLOAD > /dev/null
echo -e "${Green}Download-update.sh has been updated${NC}"

bash $ROOT_FOLDER/$UPDATE_DOWNLOAD