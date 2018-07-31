#!/bin/sh
# CRONTAB:
#  0 * * * * ~/dotfiles/logitech/autoswitch.sh

HOUR=`date +%H`
PROFILE_DIR=$(dirname "$0")
PROFILE="g810-dark.profile"
if test $HOUR -gt 8 -a $HOUR -lt 22; then
	PROFILE="g810-light.profile"
fi
if test -f "$PROFILE_DIR/$PROFILE"; then
	g810-led -p "$PROFILE_DIR/$PROFILE"
fi
