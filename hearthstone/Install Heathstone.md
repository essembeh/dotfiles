# Install Hearthstone on Debian Buster


## Install needed packages

```sh
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install wine cabextract
```

## Prepare wine

>Note: You need to install [Winetricks]([winetricks](https://github.com/Winetricks/winetricks)) from the sources to fix a `vcrun` issue.

```sh
export WINEPREFIX=~/.wine-hs
mkdir -p $WINEPREFIX
wineboot
git clone https://github.com/Winetricks/winetricks ~/.winetricks
~/.winetricks/src/winetricks fonts corefonts
~/.winetricks/src/winetricks dlls vcrun2017
~/.winetricks/src/winetricks settings win10
```

## Install Battle.net

```sh
export WINEPREFIX=~/.wine-hs
wget 'https://eu.battle.net/download/getInstaller?os=win&installer=Hearthstone-Setup.exe' -O /tmp/hs-setup.exe
wine /tmp/hs-setup.exe
```

## Backup

I use [borgbackup](https://www.borgbackup.org/) to perform incremental backups of my `~/.wine-hs` folder after every Hearthstone update, just in case ;)
```sh
export BORG_REPO=MyNAS.local:wine-hs.borg
borg init -e none # Executed only once to initialise the repository
borg create -p -s ::{now} ~/.wine-hs
```

## Troubleshooting

Some older wine needed to add `-force-d3d9` as extra argument to Hearthstone in Battle.net. I don't need this anymore but it might be useful in case of black screen.


If your mouse & keyboard become inactive when you ALT-TAB and change focus, try:
- open regedit with `WINEPREFIX=~/.wine-hs regedit`
- go to `HKEY_CURRENT_USER\Software\Wine\X11 Driver`
- create a new entry named `UseTakeFocus` with value `N`
