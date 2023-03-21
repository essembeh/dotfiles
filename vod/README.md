> Install [yt-dlp](https://github.com/yt-dlp/yt-dlp) with `pipx install yt-dlp`

# Mirror Youtube channels

Create you mirror configuration, for example `youtube.conf`

```conf
# Lines starting with # are ignored
# Format:
#   - column #1: subfolder to download files, relative to your conf file
#   - column #2: url of the playlist, must be compatible with yt-dlp
#   - column #3 (optional): extra arguments given to yt-dlp
#  
# <FOLDER>         <URL>                                                          [EXTRA_ARGS]
Jeremy_Griffith    https://youtube.com/channel/UCa_Dlwrwv3ktrhCy91HpVRw/videos    --match-filters duration>120
```

Then periodically run

```sh
./youtube.sh youtube.conf
```

# Mirror FranceTV shows

Create you mirror configuration, for example `francetv.conf`

```conf
# Lines starting with # are ignored
# Format:
#   - column #1: subfolder to download files, relative to your conf file
#   - column #2: the channel
#   - column #3: the show id 
#   - column #4 (optional): the filename format
#  
# <FOLDER>                    <CHANNEL>   <SHOW_ID>                     [FILENAME]
Les_routes_de_l_impossible    france-5    les-routes-de-l-impossible    %(title)s (%(duration>%M)smin).%(ext)s
```

Then periodically run

```sh
./francetv.sh francetv.conf
```
