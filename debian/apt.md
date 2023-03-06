# APT repositories

### Debian bullseye

Here are the main repositories

```sh
## Debian official repositories
deb http://ftp.fr.debian.org/debian/ bullseye main contrib non-free
deb http://ftp.fr.debian.org/debian/ bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
#deb http://ftp.fr.debian.org/debian/ bullseye-backports main contrib non-free
```

And the source repositories

```sh
## Debian official repositories (source)
deb-src http://ftp.fr.debian.org/debian/ bullseye main contrib non-free
deb-src http://ftp.fr.debian.org/debian/ bullseye-updates main contrib non-free
deb-src http://security.debian.org/ bullseye/updates main contrib non-free
#deb-src http://ftp.fr.debian.org/debian/ bullseye-backports main contrib non-free
```

### Debian testing

```sh
## Debian testing official repositories
deb http://ftp.fr.debian.org/debian/ testing main contrib non-free
deb http://ftp.fr.debian.org/debian/ testing-updates main contrib non-free
deb http://security.debian.org/debian-security/ testing-security main contrib non-free
```

### Debian unstable

```sh
## Debian unstable official repositories
deb http://ftp.fr.debian.org/debian/ unstable main contrib non-free
```

### Ubuntu

> Note: replace `{RELEASE}` with the release name

```sh
## Ubuntu official repositories
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE} main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-security main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-updates main restricted universe multiverse
deb http://fr.archive.ubuntu.com/ubuntu {RELEASE}-backports main restricted universe multiverse
```

# Common Debian packages

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

- vim vim-syntastic vim-airline vim-airline-themes
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

### Flatpak

- flatpak
- gnome-software-plugin-flatpak

```sh
# add flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```
