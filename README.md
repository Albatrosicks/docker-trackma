# albatrosicks/trackma
[![Docker](https://github.com/Albatrosicks/docker-trackma/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/Albatrosicks/docker-trackma/actions/workflows/docker-publish.yml)

## Usage

```
docker run -it \
  --name trackma \
  -v /path/to/your/trackma/config:/config \
  -e ACCOUNT_USERNAME=YOUR_TRACKER_USERNAME \
  -e ACCOUNT_PASSWORD=YOUR_TRACKER_PASSWORD \
  -e ACCOUNT_API=YOUR_TRACKER \
  -e TZ=YOUR_TIMEZONE \
  albatrosicks/trackma
```
This will run Trackma in interactive mode, to keep it running in background use `-id` or `--interactive --detach`

## Plex Example

```
docker run -id \
  --name trackma \
  -v /path/to/your/trackma/config:/config \
  -e ACCOUNT_USERNAME=trackma \
  -e ACCOUNT_PASSWORD=supersecretpassword \
  -e ACCOUNT_API=mal \
  -e TZ=YOUR_TIMEZONE \
  -e AUTOSEND_MINUTES=15 \
  -e AUTO_STATUS_CHANGE_IF_SCORE=false \
  -e TRACKER_TYPE=plex \
  -e PLEX_HOST=192.168.1.123 \
  -e PLEX_OBEY_UPDATE_WAIT_S=true \
  -e PLEX_USER=your_plex_user_name \
  -e PLEX_PASSWD=supersecretpassword \
  -e PLEX_UUID=0cc4151e-fd06-11e7-8be5-0ed5f89f718b \
  albatrosicks/trackma
```
This will run Trackma in detached mode and monitor Plex and update your MAL anime list automatically.
It is important to use your Plex username to login instead of email or you may encounter this bug described [here](https://github.com/z411/trackma/issues/464)

## Parameters

* `-v /config` - Trackma config
* `-e ACCOUNT_USERNAME` - Your username of the tracker you will be using
* `-e ACCOUNT_PASSWORD` - Your password of the tracker you will be using
* `-e ACCOUNT_API` - The abbreviation of the tracker you will be using (anilist|kitsu|mal|shikimori|vndb)
* `-e TZ` - Timezone Trackma will run in
* Trackma configurations can be overriden by setting container environment variables:
    * Simple set the configuration you want to configure using `-e EXAMPLE=value` uppercasing the configuration key
    * For example using `-e SEARCHDIR="/mymedia/videos"` will change the directory Trackma scans for video files
    * All configurable options are available and can be found [here](https://github.com/z411/trackma/blob/master/trackma/utils.py#L350) not all options may be available depending on the version of Trackma you choose to use
    * For a detailed explanation of what most of them do see [here](https://github.com/z411/trackma/wiki/Configuration-File)
