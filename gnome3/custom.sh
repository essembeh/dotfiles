#!/bin/sh

set -x 
set -e

gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:'

gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"

mkdir -p ${HOME}/.config/gtk-3.0/
cp $(dirname "$0")/settings.ini ${HOME}/.config/gtk-3.0/

mkdir -p ${HOME}/.local/share/applications/
cp $(dirname "$0")/mplayer.desktop ${HOME}/.local/share/applications/
cat /usr/share/applications/mimeinfo.cache | fgrep "org.gnome.Totem.desktop" | sed "s/org.gnome.Totem.desktop/mplayer.desktop/" > ${HOME}/.local/share/applications/mimeinfo.cache
