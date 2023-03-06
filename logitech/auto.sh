#!/bin/sh
# CRONTAB:
#  0 * * * * ~/dotfiles/logitech/autoswitch.sh
set -eu

FOLDER=$(dirname "$0")

PROFILE="g810-dark.profile"
HOUR=$(date +%H)
if test $HOUR -ge 8 -a $HOUR -le 20; then
	PROFILE="g810-light.profile"
fi
if test -f "$FOLDER/$PROFILE"; then
	"$FOLDER/g810-led" -p "$FOLDER/$PROFILE"
fi
