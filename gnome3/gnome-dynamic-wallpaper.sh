#!/bin/sh
set -e

DEFAULT_FILE="$HOME/.wallpaper.xml"
DURATION=60
TRANSITION=1
MODE="zoom"
FIST_IMAGE=""
PREVIOUS_IMAGE=""
OPTION_SET=false

__usage () {
echo "NAME
	gnome-dynamic-wallpaper - Tool to create a dynamic wallpaper for gnome3

USAGE
	gnome-dynamic-wallpaper 01.JPG 02.JPG 03.jpg 
	gnome-dynamic-wallpaper 01.JPG 02.JPG 03.jpg > ~/.wallpaper.xml
	gnome-dynamic-wallpaper --write *.jpg
	gnome-dynamic-wallpaper --duration 60 --transition 5 --write --mode spanned *.jpg

OPTIONS
	-h, --help
		Diplay this message.

	--duration N
		Set image duration in sec, default 60
	
	--mode zoom|spanned|wallpaper|centered|scaled|stretched|none
		Rendering mode

	--transition N
		Set transition duration in sec, default 1

	--write
		Writes output to $DEFAULT_FILE and use gsettings to use it.
	
"
}
while test -n "$1"; do
	case $1 in 
		--write) OPTION_SET=true ;;
		--duration) shift; DURATION="$1";;
		--transition) shift; TRANSITION="$1";;
		--mode) shift; MODE="$1";;
		-h|--help) __usage; exit 0;;
		*) break;;
	esac
	shift
done
test "$OPTION_SET" = "false" || exec > "$DEFAULT_FILE"
echo "<background>"
echo "  <starttime><hour>0</hour><minute>00</minute><second>00</second></starttime>"
for IMAGE in "$@"; do
	CURRENT_IMAGE=$(realpath "$IMAGE")
	test -f "$CURRENT_IMAGE"
	test -n "$FIST_IMAGE" || FIST_IMAGE="$CURRENT_IMAGE"
	if [ -n "$PREVIOUS_IMAGE" ]; then
		echo "  <transition><duration>$TRANSITION</duration><from>$PREVIOUS_IMAGE</from><to>$CURRENT_IMAGE</to></transition>"
	fi
	echo "  <static><duration>$DURATION</duration><file>$CURRENT_IMAGE</file></static>"
	PREVIOUS_IMAGE="$CURRENT_IMAGE"
done
if [ -n "$FIST_IMAGE" -a -n "$PREVIOUS_IMAGE" ]; then
	echo "  <transition><duration>$TRANSITION</duration><from>$PREVIOUS_IMAGE</from><to>$FIST_IMAGE</to></transition>"
fi
echo "</background>"

if test "$OPTION_SET" = "true"; then
	gsettings set org.gnome.desktop.background picture-uri "file://$DEFAULT_FILE"
	gsettings set org.gnome.desktop.background picture-options $MODE
fi
