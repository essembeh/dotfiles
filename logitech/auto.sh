#!/bin/sh
set -eu

FOLDER="g810-led"
REPO="https://github.com/MatMoul/g810-led"
PROFILE="g810-dark.profile"
HOUR=$(date +%H)


cd "$(dirname "$0")"

if ! test -d "$FOLDER"; then
    echo "🧲 Clone $REPO --> $FOLDER"
    git clone "$REPO" "$FOLDER"
    echo "⏳ Build $FOLDER"
    nix-shell -p hidapi gnumake --run "cd \"$FOLDER\" && make clean all"
fi

if test $HOUR -ge 8 -a $HOUR -le 20; then
	PROFILE="g810-light.profile"
fi
test -f "$PROFILE"
test -x "$FOLDER/bin/g810-led"
"$FOLDER/bin/g810-led" -p "$PROFILE"


