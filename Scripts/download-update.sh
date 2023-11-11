#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Download files
echo -e "$REMOVING_OLD_SYSTEM_FILES"


if [ -e $ROOT_FOLDER/$AUTOMATED_CHECK ]; then
    rm $ROOT_FOLDER/$AUTOMATED_CHECK
fi
sleep 1
curl -s -o $ROOT_FOLDER/$AUTOMATED_CHECK $GIHUB_LINK/Scripts/$AUTOMATED_CHECK > /dev/null

if [ -e $ROOT_FOLDER/$SETUP_PLEX ]; then
    rm $ROOT_FOLDER/$SETUP_PLEX
fi
sleep 1
curl -s -o $ROOT_FOLDER/$SETUP_PLEX $GIHUB_LINK/Scripts/$SETUP_PLEX > /dev/null

if [ -e $ROOT_FOLDER/$DOWNLOAD ]; then
    rm $ROOT_FOLDER/$DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOWNLOAD $GIHUB_LINK/Scripts/$DOWNLOAD > /dev/null

if [ -e $ROOT_FOLDER/$DOCKER_STOP ]; then
    rm $ROOT_FOLDER/$DOCKER_STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$DOCKER_STOP $GIHUB_LINK/Scripts/$DOCKER_STOP > /dev/null

if [ -e $ROOT_FOLDER/$STOP ]; then
    rm $ROOT_FOLDER/$STOP
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP $GIHUB_LINK/Scripts/$STOP > /dev/null

if [ -e $ROOT_FOLDER/$UNINSTALL ]; then
    rm $ROOT_FOLDER/$UNINSTALL
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UNINSTALL $GIHUB_LINK/Scripts/$UNINSTALL > /dev/null

if [ -e $ROOT_FOLDER/$STOP_REMOVE ]; then
    rm $ROOT_FOLDER/$STOP_REMOVE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$STOP_REMOVE $GIHUB_LINK/Scripts/$STOP_REMOVE > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE ]; then
    rm $ROOT_FOLDER/$UPDATE
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE $GIHUB_LINK/Scripts/$UPDATE > /dev/null

if [ -e $ROOT_FOLDER/$ADD_URL_LIST ]; then
    rm $ROOT_FOLDER/$ADD_URL_LIST
fi
sleep 1
curl -s -o $ROOT_FOLDER/$ADD_URL_LIST $GIHUB_LINK/Scripts/$ADD_URL_LIST > /dev/null

if [ -e $ROOT_FOLDER/$UPDATE_DOWNLOAD ]; then
    rm $ROOT_FOLDER/$UPDATE_DOWNLOAD
fi
sleep 1
curl -s -o $ROOT_FOLDER/$UPDATE_DOWNLOAD $GIHUB_LINK/Scripts/$UPDATE_DOWNLOAD > /dev/null

echo -e "$DOWNLOADING_NEW_FILES"