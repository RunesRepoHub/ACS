# Auto-YT-DL

Redefining media server management, our user-friendly software combines a sleek interface with powerful automation. Ideal for users with robust servers, it effortlessly downloads movies, shows, and YouTube videos, while intuitively configuring and maintaining Plex, Ombi, Jackett, Sonarr, Radarr, Deluge, Tautulli, and Mikenye/YouTube-dl Docker containers. Enjoy the simplicity of organized folders and files, making setup and maintenance a breeze. Elevate your media server experience with an innovative solution that seamlessly integrates ease of use with advanced capabilities.

## Setup.sh

This script streamlines the setup of the Auto-YT-DL application with a comprehensive set of actions. It defines color variables for terminal output, sets the app version, and ensures a clean environment. Checking for necessary dependencies like Docker, sudo, and curl, the script installs and configures them as needed. It downloads Docker images, shell scripts from GitHub, and establishes essential folders with proper permissions. User interaction is facilitated through prompts for configuration settings, including the maximum number of containers for YouTube downloading. The script automates Plex setup, adds aliases and cron jobs, and concludes with a user-friendly completion message and instructions for utilizing custom commands. This user interface-centric approach enhances both functionality and ease of maintenance.

## Download.sh 

The script efficiently manages the mikenye/youtube-dl Docker image, first checking for its presence and displaying a corresponding message if it exists. If the image is not already downloaded, the script utilizes the "docker pull" command to fetch the mikenye/youtube-dl Docker image. A confirmation message is then displayed, informing the user that the image has been successfully downloaded. This ensures that the latest version of the image is readily available for use in the Auto-YT-DL application, enhancing the script's functionality and user communication.

## Uninstall.sh

This user-interactive script facilitates the management of the Plex media folder based on user preferences. After prompting the user to choose between keeping or deleting the Plex media folder, the script dynamically adjusts its actions accordingly:

1. Keep Plex Media Folder Option:

* Stops and removes Docker containers with the mikenye/youtube-dl image.
* Stops and removes Docker containers for jackett, radarr, sonarr, tautulli, deluge, and ombi.
* Removes the my_plex_network Docker network.
* Clears all folders and files associated with the Auto-YT-DL application except for the Plex media folder.
* Removes the line from the crontab file that runs the automated-check.sh script.

2. Delete Plex Media Folder Option (In addition to the above):

* Removes the Plex media folder.

3. Invalid Response Handling:

* Displays an error message for invalid responses, guiding the user to provide a valid input.

This modular and responsive design ensures that the script caters to user preferences while maintaining clarity and control over the automated cleanup process.