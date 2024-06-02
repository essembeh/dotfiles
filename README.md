# My _dotfiles_

Repository containing most of my configuration files

> See [Debian specific configuration](./debian/apt.md) documentation.

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

- [com.belmoussaoui.Authenticator](https://flathub.org/apps/details/com.belmoussaoui.Authenticator)
- [org.avidemux.Avidemux](https://flathub.org/apps/details/org.avidemux.Avidemux)
- [dev.bsnes.bsnes](https://flathub.org/apps/details/dev.bsnes.bsnes)
- [org.ferdium.Ferdium](https://flathub.org/apps/details/org.ferdium.Ferdium)
- [com.github.tchx84.Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal)
- [org.gimp.GIMP](https://flathub.org/apps/details/org.gimp.GIMP)
  - `org.gimp.GIMP.Plugin.GMic`
  - `org.gimp.GIMP.Plugin.LiquidRescale`
  - `org.gimp.GIMP.Plugin.Resynthesizer`
- [fr.handbrake.ghb](https://flathub.org/apps/details/fr.handbrake.ghb)
- [org.jitsi.jitsi-meet](https://flathub.org/apps/details/org.jitsi.jitsi-meet)
- [org.kde.kdenlive](https://flathub.org/apps/details/org.kde.kdenlive)
- [org.libreoffice.LibreOffice](https://flathub.org/apps/details/org.libreoffice.LibreOffice)
- [io.mpv.Mpv](https://flathub.org/apps/details/io.mpv.Mpv)
- [dev.k8slens.OpenLens](https://flathub.org/apps/details/dev.k8slens.OpenLens)
- [io.github.ec\_.Quake3e.OpenArena](https://flathub.org/apps/details/io.github.ec_.Quake3e.OpenArena)
- [org.remmina.Remmina](https://flathub.org/apps/details/org.remmina.Remmina)
- [org.signal.Signal](https://flathub.org/apps/details/org.signal.Signal)
- [org.telegram.desktop](https://flathub.org/apps/details/org.telegram.desktop)
- [com.vscodium.codium](https://flathub.org/apps/details/com.vscodium.codium)

Non-free apps:

- [com.jetbrains.IntelliJ-IDEA-Community](https://flathub.org/apps/details/com.jetbrains.IntelliJ-IDEA-Community)
- [com.slack.Slack](https://flathub.org/apps/details/com.slack.Slack)
- [com.spotify.Client](https://flathub.org/apps/details/com.spotify.Client)
- [com.valvesoftware.Steam](https://flathub.org/apps/details/com.valvesoftware.Steam)

# Gnome extensions

```sh
# install gnome-extensions-cli
pip3 install --user --upgrade gnome-extensions-cli
# to install extensions
$ gnome-extensions-cli install ...
```

- [App Icons Taskbar](https://extensions.gnome.org/extension/4944/app-icons-taskbar/)
  - [Dash to Panel](https://extensions.gnome.org/extension/1160/dash-to-panel/)
- [AppIndicator and KStatusNotifierItem Support](https://extensions.gnome.org/extension/615/appindicator-support/)
- [Tiling Assistant](https://extensions.gnome.org/extension/3733/tiling-assistant/)
  - [Forge](https://extensions.gnome.org/extension/4481/forge/)
- [Freon](https://extensions.gnome.org/extension/841/freon/)
- [Grand Theft Focus](https://extensions.gnome.org/extension/5410/grand-theft-focus/)
- [Applications Menu](https://extensions.gnome.org/extension/6/applications-menu/)
- [Tailscale Status](https://extensions.gnome.org/extension/5112/tailscale-status/)
- [Todo.txt](https://extensions.gnome.org/extension/570/todotxt/)
- [Emoji Copy](https://extensions.gnome.org/extension/6242/emoji-copy/)
- [Workspace Indicator](https://extensions.gnome.org/extension/21/workspace-indicator/)
- [Panel Workspace Scroll ](https://extensions.gnome.org/extension/6523/panel-workspace-scroll/)
  - [Top Panel Workspace Scroll](https://extensions.gnome.org/extension/701/top-panel-workspace-scroll/)
- [Impatience](https://extensions.gnome.org/extension/277/impatience/)
- [Syncthing Indicator](https://extensions.gnome.org/extension/1070/syncthing-indicator/)
