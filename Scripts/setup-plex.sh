#!/bin/bash
source ~/Auto-YT-DL/Scripts/Core.sh

# Set the IP address and time zone
IP=$(hostname -I | awk '{print $1}')
TZ=$(timedatectl show --property=Timezone --value)

# Check if the network already exists
if docker network inspect my_plex_network >/dev/null 2>&1; then
    echo -e "$DOCKER_NETWORK_ALREADY_EXIST"
    echo -e "$INSTALL_MIGHT_FAIL"
else
    # Create the network
    docker network create my_plex_network
fi

# Check if there is already a docker with the name plex running

if docker ps -a --format '{{.Names}}' | grep -q "^plex$"; then
    echo -e "$DOCKER_CLAIM_PLEX_ALREADY"
else
    echo -e "$DOCKER_CLAIM_PLEX_TEXT"
    echo -e "$DOCKER_CLAIM_PLEX_URL"

    # Prompt the user for the Plex claim
    read -p "Enter the Plex claim: " PLEX_CLAIM

    # Check if PLEX_CLAIM is empty
    if [ -z "$PLEX_CLAIM" ]; then
        echo -e "$INVALID_ARGUMENTS"
        exit 1
    fi


    echo -e "$DOCKER_CLAIM_PLEX_HOSTNAME_TEXT"    
    # Prompt the user for the hostname
    read -p "Hostname for Plex-Server: " PLEX_HOST

    # Run the plex service
    docker run \
        -d \
        --name plex \
        --network my_plex_network \
        --memory 4g \
        -p 32400:32400/tcp \
        -p 3005:3005/tcp \
        -p 8324:8324/tcp \
        -p 32469:32469/tcp \
        -p 1900:1900/udp \
        -p 32410:32410/udp \
        -p 32412:32412/udp \
        -p 32413:32413/udp \
        -p 32414:32414/udp \
        -e TZ="$TZ" \
        -e PLEX_CLAIM="$PLEX_CLAIM" \
        -e ADVERTISE_IP="http://$IP:32400/" \
        -h "$PLEX_HOST" \
        -v "$DOCKER_PLEX_LIBRARY_FOLDER:/$DOCKER_CONFIG_FOLDER" \
        -v "$DOCKER_TRANSCODE_FOLDER:/$DOCKER_TRANSCODE_MOUNT" \
        -v "$DOCKER_PLEX_MEDIA:/$DOCKER_PLEX_DATA" \
        --restart $DOCKER_RESTART_ALWAYS \
        plexinc/pms-docker
fi

# Run the jackett service
docker run -d \
  --name jackett \
  --network my_plex_network \
  --memory 2g \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ="$TZ" \
  -e AUTO_UPDATE=true \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_JACKETT_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -v $DOCKER_DOWNLOAD_FOLDER:/$DOCKER_MOUNT_DOWNLOAD_FOLDER \
  -p 9117:9117 \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/jackett:latest

# Run the radarr service
docker run -d \
  --name radarr \
  --network my_plex_network \
  --memory 2g \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ="$TZ" \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_RADARR_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -v $DOCKER_HOST_MOVIES_FOLDER:/$DOCKER_MOVIES_FOLDER \
  -v $DOCKER_DOWNLOAD_FOLDER:/$DOCKER_MOUNT_DOWNLOAD_FOLDER \
  -p 7878:7878 \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/radarr:latest

# Run the sonarr service
docker run -d \
  --name sonarr \
  --network my_plex_network \
  --memory 2g \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ="$TZ" \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_SONARR_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -v $DOCKER_HOST_SHOWS_FOLDER:/$DOCKER_SHOWS_FOLDER \
  -v $DOCKER_DOWNLOAD_FOLDER:/$DOCKER_MOUNT_DOWNLOAD_FOLDER \
  -p 8989:8989 \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/sonarr:latest

# Run the tautulli service
docker run -d \
  --name tautulli \
  --network my_plex_network \
  --memory 1g \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ="$TZ" \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_TAUTULLI_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -p 8181:8181 \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/tautulli:latest

# Run the deluge service
docker run -d \
  --name deluge \
  --network my_plex_network \
  --memory 2g \
  -e PUID=222 -e PGID=321 -e UMASK=002 \
  -e TZ="$TZ" \
  -e DELUGE_LOGLEVEL=error \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_DELUGE_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -v $DOCKER_DOWNLOAD_FOLDER:/$DOCKER_MOUNT_DOWNLOAD_FOLDER \
  -p 8112:8112 \
  -p 6881:6881 \
  -p 6881:6881/udp \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/deluge:latest

# Run the ombi service
docker run -d \
  --name ombi \
  --network my_plex_network \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ="$TZ" \
  -v $DOCKER_ROOT_FOLDER/$DOCKER_OMBI_FOLDER:/$DOCKER_CONFIG_FOLDER \
  -p 3579:3579 \
  --restart $DOCKER_RESTART_ALWAYS \
  lscr.io/linuxserver/ombi:latest

