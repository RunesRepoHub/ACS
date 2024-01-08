#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Update update.sh
echo -e "${Purple}Updating download-update.sh...${NC}"
cd ~/ACS
git pull
echo -e "${Green}Download-update.sh has been updated${NC}"