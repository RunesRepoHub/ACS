source ~/ACS/ACSF-Scripts/Core.sh

version: '3.8'

services:
  plex:
    container_name: plex
    image: plexinc/pms-docker
    network_mode: my_plex_network
    mem_limit: 4g
    ports:
      - "32400:32400/tcp"
      - "3005:3005/tcp"
      - "8324:8324/tcp"
      - "32469:32469/tcp"
      - "1900:1900/udp"
      - "32410:32410/udp"
      - "32412:32412/udp"
      - "32413:32413/udp"
      - "32414:32414/udp"
    volumes:
      - "~/plex/library:/config"
      - "~/plex/transcode/temp:/transcode"
      - "~/plex/media:/data"
    restart: "always"
