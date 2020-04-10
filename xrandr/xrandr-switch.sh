#!/bin/bash
set -eux

DEFAULT="auto"
DEFAULT_SINGLE="single-left"
DEFAULT_DUAL="dual-right"

LEFT="HDMI-1"
RIGHT="HDMI-2"

WALLPAPER_DIR="$HOME/.cache/wallpapers"
WALLPAPER_LEFT="$WALLPAPER_DIR/${WALLPAPER:-default}/left"
WALLPAPER_RIGHT="$WALLPAPER_DIR/${WALLPAPER:-default}/right"
WALLPAPER_DUAL="$WALLPAPER_DIR/${WALLPAPER:-default}/dual"
WALLPAPER_SINGLE="$WALLPAPER_DIR/${WALLPAPER:-default}/single"

if test $# -eq 1; then
	case "$1" in
		"gui")
			MODE=$(zenity \
					--list \
					--radiolist \
					--title="Select monitor mode" \
					--column="" --column="Mode" --column="Descripotion" \
					"" auto "Auto swith between $DEFAULT_DUAL and $DEFAULT_SINGLE" \
					"" single-left "Only left monitor" \
					"" single-right "Only right monitor" \
					"" dual-left "Dual monitor, primary on left" \
					"" dual-right "Dual monitor, primary on right" \
				)
			echo "Selected mode: $MODE"
			;;
		*)
			MODE="$1"
			;;
	esac
else
	MODE="$DEFAULT"
fi

# Generate dual wallpaper if needed
if test -f "$WALLPAPER_LEFT" -a -f "$WALLPAPER_RIGHT" -a ! -f "$WALLPAPER_DUAL"; then
	convert +append "$WALLPAPER_LEFT" "$WALLPAPER_RIGHT" "$WALLPAPER_DUAL"
fi

__set_wallpaper() {
	OPTION=$1
	shift
	while test $# -gt 0; do
		if test -f "$1"; then
			FILE=$(readlink -f "$1")
			gsettings set org.gnome.desktop.background picture-uri "file://$FILE"
			gsettings set org.gnome.desktop.background picture-options $OPTION
			break
		fi
		shift
	done
}

if test "$MODE" = "auto"; then
	if test "$(xrandr --listactivemonitors | head -1)" = "Monitors: 1"; then
		MODE="$DEFAULT_DUAL"
	else
		MODE="$DEFAULT_SINGLE"
	fi
fi

# Swith mode
case "$MODE" in
	"single-left")
		xrandr --output $LEFT --auto --primary
		xrandr --output $RIGHT --off
		__set_wallpaper zoom "$WALLPAPER_SINGLE" "$WALLPAPER_LEFT"
		;;
	"single-right")
		xrandr --output $RIGHT --auto --primary
		xrandr --output $LEFT --off
		__set_wallpaper zoom "$WALLPAPER_SINGLE" "$WALLPAPER_RIGHT"
		;;
	"dual-left")
		xrandr --output $LEFT --auto --primary
		xrandr --output $RIGHT --auto --right-of $LEFT
		__set_wallpaper spanned "$WALLPAPER_DUAL" 
		;;
	"dual-right")
		xrandr --output $RIGHT --auto --primary
		xrandr --output $LEFT --auto --left-of $RIGHT
		__set_wallpaper spanned "$WALLPAPER_DUAL" 
		;;
	*)
		echo "Usage $0 single-left|single-right|dual-left|dual-right"
		echo "   or $0 help|gui|auto"
		exit 1
esac
