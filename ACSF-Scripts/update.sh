#!/bin/bash

source ~/ACS/ACSF-Scripts/Core.sh

# Update update.sh
echo -e "${Purple}Updating ACS...${NC}"
cd ~/ACS

read -p "Enter the branch you want to clone or pull: " branch
git pull --branch "$branch"

# Add alias
echo -e "${Purple}Setup alias${NC}"
# Add aliases to the shell configuration file

bash $ROOT_FOLDER/$ALIASES

echo -e "${Green}Aliases have been updated${NC}"
