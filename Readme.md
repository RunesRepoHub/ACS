# Auto-YT-DL

The code is a Bash script that reads URLs from a text file, downloads videos from those URLs using the mikenye/youtube-dl Docker container, and manages the number of running containers to avoid exceeding a specified limit.

How? The code follows these steps:

* Reads the URLs from a text file located at ~/plex/media/url_file.txt.

* Sets the output path for downloaded videos to ~/plex/media/youtube.

* Defines the maximum number of running containers as 3 and initializes the current number of containers to 0.

* Loops over each URL from the text file:

* Sets the video file path based on the URL.

* Creates the video folder if it doesn't exist.

* Checks the number of running mikenye/youtube-dl Docker containers and waits if the maximum is reached.

* Increments the current number of running containers.

* Downloads the video using the mikenye/youtube-dl Docker container with various options.

* Decrements the current number of running containers.

## Coupling and Cohesion: 

The code appears to have low coupling and high cohesion. The functions and variables are appropriately scoped and organized within the script.

## Single Responsibility Principle: 
The code follows the Single Responsibility Principle to some extent. However, the section responsible for managing the number of running containers could be extracted into a separate function to improve code modularity and readability.

# Install command

```
bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/setup.sh)
```

### Docker is required

Docker is required to run this software

[Get Docker on Debian 12](https://linuxiac.com/how-to-install-docker-on-debian-12-bookworm/
)

# Easy command

After the install has finished you can use these commands for quick access and control

Run this command to enable the custom commands

```
source ~/.bashrc
```

## Add url 

This is how you add more then one url

You can also modify the `~/plex/media/url_file.txt` this file contains all the urls

``` 
add-url
```

## Get an easy overview

Quickly get an overview of the downloading docker containers.

Use this command

```
get-overview
```

## Trigger an manuel download

Want to download a new video manually that has not yet been downloaded automatically.

Use this command

```
start-download
```

## Stop an download

Want to stop an download, if you need it to abort a download

Use this command

```
stop-download
```

## Stop all running dockers

Want to stop all the docker at ones 

Use this command

```
stop-all
```

## Uninstall and delete

Want to uninstall everything and delete everything or uninstall and delete everything but keep the plex media folder.

Use this command

```
yt-uninstall
```

# Error Codes

Error codes used in this "software"

## 302 — Found:

* A 302 error code is that the requested resource already exists at the specified location.