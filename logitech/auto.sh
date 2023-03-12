#!/bin/sh
# CRONTAB:
#  0 * * * * ~/dotfiles/logitech/autoswitch.sh
set -eu

G810_BIN="$HOME/Projects/g810-led/bin/g810-led"
test -x "$G810_BIN"

FOLDER=$(dirname "$0")

PROFILE="g810-dark.profile"
HOUR=$(date +%H)
if test $HOUR -ge 8 -a $HOUR -le 20; then
	PROFILE="g810-light.profile"
fi
if test -f "$FOLDER/$PROFILE"; then
	"$G810_BIN" -p "$FOLDER/$PROFILE"
fi
