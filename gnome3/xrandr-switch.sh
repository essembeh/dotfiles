#!/bin/bash
set -eux

DEFAULT="gui"
DEFAULT_SINGLE="single-left"
DEFAULT_DUAL="dual-right"

LEFT="XWAYLAND0"
RIGHT="XWAYLAND1"

MODE="$DEFAULT"
if test $# -eq 1; then
	MODE="$1"
fi
if test "$MODE" = "gui"; then
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
fi
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
		;;
	"single-right")
		xrandr --output $RIGHT --auto --primary
		xrandr --output $LEFT --off
		;;
	"dual-left")
		# Generate dual wallpaper if needed
		if test -f "$WALLPAPER_LEFT" -a -f "$WALLPAPER_RIGHT" -a ! -f "$WALLPAPER_DUAL"; then
			convert +append "$WALLPAPER_LEFT" "$WALLPAPER_RIGHT" "$WALLPAPER_DUAL"
		fi
		xrandr --output $LEFT --auto --primary
		xrandr --output $RIGHT --auto --right-of $LEFT
		;;
	"dual-right")
		# Generate dual wallpaper if needed
		if test -f "$WALLPAPER_LEFT" -a -f "$WALLPAPER_RIGHT" -a ! -f "$WALLPAPER_DUAL"; then
			convert +append "$WALLPAPER_LEFT" "$WALLPAPER_RIGHT" "$WALLPAPER_DUAL"
		fi
		xrandr --output $RIGHT --auto --primary
		xrandr --output $LEFT --auto --left-of $RIGHT
		;;
	*)
		echo "Usage $0 single-left|single-right|dual-left|dual-right"
		echo "   or $0 help|gui|auto"
		exit 1
esac
