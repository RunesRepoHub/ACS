# Auto-YT-DL

## Index

* [Jackett Javascript](https://github.com/RunesRepoHub/YT-Plex/blob/Production/Docs/Jackett-javascript.md)
* [Configure WebGUI's](https://github.com/RunesRepoHub/YT-Plex/blob/Production/Docs/Config-Web.md)


### Docker is required

Docker is required to run this software

[Get Docker on Debian 12](https://linuxiac.com/how-to-install-docker-on-debian-12-bookworm/
)

# Install command

```
bash <(wget -qO- https://raw.githubusercontent.com/RunesRepoHub/YT-Plex/Production/setup.sh)
```

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
