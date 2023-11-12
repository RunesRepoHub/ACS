### Supported Platforms:
![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white) ![Debian](https://img.shields.io/badge/Debian-D70A53?style=for-the-badge&logo=debian&logoColor=white) 

### Made With
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/github%20actions-%232671E5.svg?style=for-the-badge&logo=githubactions&logoColor=white) ![Github Pages](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)

## Youtube-dl Performence

!!! danger "Performence"

    The Youtube-dl has some issues when it comes to downloading.
    Mainly because of long playlists and/or multiple downloads running at ones.

    This will result in these errors. (And possible more)

    * Can cause a softlog error on proxmox when running it an VM.

    * The longer the playlists the longer the download. (At download 86 of 156 it takes 30 mins of 400mb of data, THIS is NOT a networking limit)

    * Can cause a but of slow down on plex itself if configured to update library on every change dectected in the folder.

### Requriements 
!!! question "Requirements"

    **OS Supported:**

    * Debian 12 (Tested) 
    * Debian 11 (Tested)
    * Ubuntu 22.04 (Tested)
    * Zorin 16.3 Core (Tested) 

    ***This has been setup as root on all server OS***

    **User**

    * Username: root (NOT OPTIONAL)
    * Set new password for the root user
    * Enable SSH for root
    * Change to the root user with `su - root`

    **Docker**

    * Install Docker + Docker-compose on the server.

    **Server**

    * Has to have ~/.bashrc for custom commands
    * Has to have bash installed
    * Has to have a working internet connection
    * Has to be a Debian based server
    * Has to be up to date with the OS (apt-get update + apt-get upgrade)
    * Should have a FTP/SFTP on the server.
    
    **Hardware**

    * CPU : 4 cores
    * Memory : 8GB
    * Hard Disk : 100GB

    **I have allocated 5 TB of storage of my server.**

    **And I have 16GB of RAM.**

    **Youbtube-dl**

    * I would recommend using 3 youtube-dl containers with 8gb of RAM.
    * And 5 youtube-dl containers with 16gb of RAM.