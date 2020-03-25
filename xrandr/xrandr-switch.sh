#!/bin/bash
set -eux

LEFT="HDMI-1"
RIGHT="HDMI-2"

WALLPAPER1=$HOME/.wallpaper-single.jpg
WALLPAPER2=$HOME/.wallpaper-dual.jpg

if test "$(xrandr --listactivemonitors | head -1)" = "Monitors: 1"; then
	xrandr --output $RIGHT --auto --primary
	xrandr --output $LEFT --auto --left-of $RIGHT
	if test -r "$WALLPAPER2"; then
		gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER2"
		gsettings set org.gnome.desktop.background picture-options spanned
	fi
else
	xrandr --output $LEFT --primary
	xrandr --output $RIGHT --off
	if test -r "$WALLPAPER1"; then
		gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER1"
		gsettings set org.gnome.desktop.background picture-options zoom
	fi
fi
