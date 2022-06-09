# My *dotfiles*

Repository containing most of my configuration files

> Since the setup uses `make`, be sure you have this package installed:

```sh
# install required dependencies
$ sudo apt install make git

# clone the repository
$ git clone https://github.com/essembeh/dotfiles
$ cd dotfiles

# sync the git submodules
$ make
# install mandatory packages and use zsh
$ make install
# install configuration for a headless server
$ make headless
# install configuration for Gnome3 desktop
$ make desktop
# install useful python apps
$ make apps

# typical setup
$ make install desktop
```


# Debian packages

## Base

### Shell
- bash bash-completion
- zsh
- tmux
- mosh
- autojump

### Crypto
- cryptsetup
- tomb steghide qrencode
- gocryptfs
- age
- keepassx

### Archive
- p7zip-full
- lftp
- borgbackup
- syncthing
- backupninja
- unrar-nonfree
- rdiff-backup
- cabextract

### Vitualization
- docker.io docker-compose
- virt-manager
- wine
```sh
$ sudo dpkg --add-architecture i386
```

### Filesystems
- mdadm lvm2
- gparted
- fatsort exfat-fuse exfat-utils
- autofs smbnetfs sshfs libimobiledevice-utils libimobiledevice6 ifuse
- android-tools-adb android-tools-fastboot

### Network
- rsync aria2 curl wget httpie
- wireguard
- openvpn network-manager-openvpn-gnome
- fail2ban
- ufw gufw
- shorewall
- ntp
- libpam-google-authenticator

### Utils
- unattended-upgrades needrestart apt-file
- tree multitail pydf htop moreutils ncdu iotop
- nmap iptraf iftop net-tools dnsutils
- schroot
- secure-delete
- logwatch
- exa
- sysfsutils

### Server
- openssh-server
- nfs-kernel-server
- apache2
- nginx-full
- php php-cli php-fpm
- php-mysql php-sqlite php-gd php-curl php-xsl
- mariadb-server mariadb-client
- phpmyadmin
- adminer

### Hardware
- smartmontools
- lm-sensors
- g810-led


## Desktop 

### Gnome
- gnome-tweak-tool
- gnome-brave-icon-theme
```sh
$ pip3 install --user --upgrade pipx
$ pipx install git+https://github.com/essembeh/gnome-extensions-cli
$ gnome-extensions-cli update --install 1160 1031 15 2087 21 277 1227 841 1319
```

### Flatpak
- flatpak gnome-software-plugin-flatpak

### Image
- gimp gimp-plugin-registry gimp-gmic
- glimpse
- libimage-exiftool-perl imagemagick
- gthumb
- freecad

### Audio
- gstreamer1.0-libav
- audacious audacious-plugins
- quodlibet
- eyed3
- exfalso

### Video
- mpv
- vlc
- kodi
- ffmpeg
- handbrake
- openshot
- pitivi

### Subtitles
- subtitleeditor
- gaupol
- gnome-subtitles

### Networking
- firefox-esr firefox-esr-l10n-fr
- xul-ext-noscript xul-ext-ublock-origin
- thunderbird thunderbird-l10n-fr
- lightning lightning-l10n-fr
- chromium
- telegram-dektop
- transmission-gtk
- filezilla
- barrier

### IRC 
- weechat weechat-plugins weechat-scripts
- irssi irssi-scripts


## Development

### Base
- git tig git-crypt
- build-essential
- manpages manpages-dev

### Editors
- vim vim-pathogen vim-syntastic vim-airline vim-airline-themes
- geany geany-plugins
- gedit gedit-plugins
- meld bvi colordiff

### Java
- openjdk-11-jre openjdk-11-jre-headless
- openjdk-11-jdk-headless openjdk-11-jdk openjdk-11-source
- ant maven

### Python            
- python3-pip
- python3-venv

### Misc
- xmlindent xmlstarlet
- xsltproc libsaxonb-java
- jq libjson-pp-perl
- rerun
- shellcheck

# Flatpack packages
```sh
# add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# to support user themes
$ sudo flatpak override --filesystem=~/.themes
# to install packages
flatpak install ...
```

## Free
- com.github.tchx84.Flatseal
- com.vscodium.codium
- org.signal.Signal
- org.telegram.desktop
- com.github.debauchee.barrier
- org.jitsi.jitsi-meet
- org.kde.kdenlive
- fr.handbrake.ghb

## Non-free
- com.spotify.Client
- com.valvesoftware.Steam

# Python packages

```sh
# to install pipx
pip3 install --user --upgrade pipx
# to install packages
pipx install ...
```
- poetry
- black
- ezfuse virenamer properties-tools
- youtube-dl yt-dlp


# Brew packages

```sh
# to install packages
brew install ...
```

- kubectl k9s helm kustomize sops age 
