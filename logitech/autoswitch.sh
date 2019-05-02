#!/bin/sh
# CRONTAB:
#  0 * * * * ~/dotfiles/logitech/autoswitch.sh

set -eu

HOUR=`date +%H`
PROFILE_DIR=$(dirname "$0")
PROFILE="g810-dark.profile"
if test $HOUR -ge 8 -a $HOUR -le 20; then
	PROFILE="g810-light.profile"
fi
if test -f "$PROFILE_DIR/$PROFILE"; then
	g810-led -p "$PROFILE_DIR/$PROFILE"
fi
