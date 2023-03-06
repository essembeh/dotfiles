# My _dotfiles_

Repository containing most of my configuration files

See [Debian](./debian/apt.md) for Debian specific configuration

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

- [Authenticator](https://flathub.org/apps/details/com.belmoussaoui.Authenticator)
- [Avidemux](https://flathub.org/apps/details/org.avidemux.Avidemux)
- [Barrier](https://flathub.org/apps/details/com.github.debauchee.barrier)
- [bsnes](https://flathub.org/apps/details/dev.bsnes.bsnes)
- [Ferdium](https://flathub.org/apps/details/org.ferdium.Ferdium)
- [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
- [GIMP](https://flathub.org/apps/details/org.gimp.GIMP)
  - `org.gimp.GIMP.Plugin.GMic`
  - `org.gimp.GIMP.Plugin.LiquidRescale`
  - `org.gimp.GIMP.Plugin.Resynthesizer`
- [HandBrake](https://flathub.org/apps/details/fr.handbrake.ghb)
- [IntelliJ IDEA Community](https://flathub.org/apps/details/com.jetbrains.IntelliJ-IDEA-Community)
- [Jitsi Meet](https://flathub.org/apps/details/org.jitsi.jitsi-meet)
- [Kdenlive](https://flathub.org/apps/details/org.kde.kdenlive)
- [LibreOffice](https://flathub.org/apps/details/org.libreoffice.LibreOffice)
- [mpv](https://flathub.org/apps/details/io.mpv.Mpv)
- [Open Lens](https://flathub.org/apps/details/dev.k8slens.OpenLens)
- [OpenArena](https://flathub.org/apps/details/io.github.ec_.Quake3e.OpenArena)
- [Remmina](https://flathub.org/apps/details/org.remmina.Remmina)
- [Signal](https://flathub.org/apps/details/org.signal.Signal)
- [Slack](https://flathub.org/apps/details/com.slack.Slack)
- [Spotify](https://flathub.org/apps/details/com.spotify.Client)
- [Steam](https://flathub.org/apps/details/com.valvesoftware.Steam)
- [Telegram Desktop](https://flathub.org/apps/details/org.telegram.desktop)
- [VSCodium](https://flathub.org/apps/details/com.vscodium.codium)

# Gnome extensions

```sh
# install gnome-extensions-cli
pip3 install --user --upgrade gnome-extensions-cli
# to install extensions
$ gnome-extensions-cli install ...
```

- [user-theme@gnome-shell-extensions.gcampax.github.com](https://extensions.gnome.org/extension/19/)
- [dash-to-panel@jderose9.github.com](https://extensions.gnome.org/extension/1160/)
- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/)
- [alternate-tab@gnome-shell-extensions.gcampax.github.com](https://extensions.gnome.org/extension/15/)
- [ding@rastersoft.com](https://extensions.gnome.org/extension/2087/)
- [workspace-indicator@gnome-shell-extensions.gcampax.github.com](https://extensions.gnome.org/extension/21/)
- [impatience@gfxmonk.net](https://extensions.gnome.org/extension/277/)
- [window-corner-preview@fabiomereu.it](https://extensions.gnome.org/extension/1227/)
- [freon@UshakovVasilii_Github.yahoo.com](https://extensions.gnome.org/extension/841/)
- [gsconnect@andyholmes.github.io](https://extensions.gnome.org/extension/1319/)

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
