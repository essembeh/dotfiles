# My _dotfiles_

Repository containing most of my configuration files

> Since the setup uses `make`, be sure you have this package installed:

```sh
# install required dependencies
$ sudo apt install make git

# clone the repository
$ git clone https://github.com/essembeh/dotfiles
$ cd dotfiles

# install mandatory packages and use zsh
$ make init
# install configuration
$ make install
```

# Debian packages

### Shell

- bash bash-completion
- zsh
- tmux
- mosh
- autojump

### Crypto

- cryptsetup
- tomb steghide qrencode zbar-tools
- gocryptfs
- age
- keepassx

### Archive

- p7zip-full
- borgbackup borgmatic
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

- lftp rsync aria2 curl wget
- wireguard
- openvpn network-manager-openvpn-gnome
- ufw gufw
- shorewall
- libpam-google-authenticator
- nfs-kernel-server
- fail2ban

### Utils

- unattended-upgrades needrestart apt-file
- tree multitail pydf htop moreutils ncdu
- nmap iptraf iftop iotop net-tools dnsutils
- secure-delete
- logwatch
- sysfsutils

### Hardware

- smartmontools
- lm-sensors
- g810-led

### Gnome

- gnome-tweak-tool
- gnome-brave-icon-theme

### Image

- gimp gimp-plugin-registry gimp-gmic
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
- ffmpeg

### Subtitles

- subtitleeditor
- gaupol
- gnome-subtitles

### IRC

- weechat weechat-plugins weechat-scripts

### Development

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

### Python

- python3-pip
- python3-venv

### Misc

- xmlindent xmlstarlet
- xsltproc libsaxonb-java
- jq libjson-pp-perl
- rerun
- shellcheck
- httpie

# Flatpack packages

```sh
# install flatpak
sudo apt install flatpak gnome-software-plugin-flatpak
# add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
# to support user themes
$ sudo flatpak override --filesystem=~/.themes
# to install packages
flatpak install ...
```

Free apps:

- com.github.tchx84.Flatseal
- com.vscodium.codium
- org.signal.Signal
- org.telegram.desktop
- com.github.debauchee.barrier
- org.jitsi.jitsi-meet
- org.kde.kdenlive
- fr.handbrake.ghb

Non-free apps:

- com.spotify.Client
- com.valvesoftware.Steam

# Gnome extensions

```sh
# install gnome-extensions-cli
pip3 install --user --upgrade gnome-extensions-cli
# to install extensions
$ gnome-extensions-cli install ...
```

- `user-theme@gnome-shell-extensions.gcampax.github.com`: [(link)](https://extensions.gnome.org/extension/19/)
- `dash-to-panel@jderose9.github.com`: [(link)](https://extensions.gnome.org/extension/1160/)
- `TopIcons@phocean.net`: [(link)](https://extensions.gnome.org/extension/1031/)
- `trayIconsReloaded@selfmade.pl`: [(link)](https://extensions.gnome.org/extension/2890/)
- `alternate-tab@gnome-shell-extensions.gcampax.github.com`: [(link)](https://extensions.gnome.org/extension/15/)
- `ding@rastersoft.com`: [(link)](https://extensions.gnome.org/extension/2087/)
- `workspace-indicator@gnome-shell-extensions.gcampax.github.com`: [(link)](https://extensions.gnome.org/extension/21/)
- `impatience@gfxmonk.net`: [(link)](https://extensions.gnome.org/extension/277/)
- `window-corner-preview@fabiomereu.it`: [(link)](https://extensions.gnome.org/extension/1227/)
- `freon@UshakovVasilii_Github.yahoo.com`: [(link)](https://extensions.gnome.org/extension/841/)
- `gsconnect@andyholmes.github.io`: [(link)](https://extensions.gnome.org/extension/1319/)

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
- borg-find
- gnome-extensions-cli
- youtube-dl yt-dlp

# Brew packages

```sh
# to install packages
brew install ...
```

- kubectl k9s helm kustomize sops age
