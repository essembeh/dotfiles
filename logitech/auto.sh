#!/bin/sh
set -eu

ROOT=$(dirname "$0")
TOOL_BIN="$ROOT/g810-led"
TMPDIR=$(mktemp -d)
REPO_URL="https://github.com/MatMoul/g810-led"
PROFILE_NIGHT="$ROOT/g810-dark.profile"
PROFILE_DAY="$ROOT/g810-light.profile"

if ! test -x "$TOOL_BIN"; then
    echo "⏳ Build $REPO_URL ..."
    git clone --quiet "$REPO_URL" "$TMPDIR"
    nix-shell -p hidapi gnumake --run "cd \"$TMPDIR\" && make clean all"
    cp -av "$TMPDIR/bin/g810-led" "$TOOL_BIN"
fi

HOUR=$(date +%H)
if test $HOUR -ge 8 -a $HOUR -le 20; then
    echo "☀ Set day profile"
    "$TOOL_BIN" -p "$PROFILE_DAY"
else
    echo "🌙 Set night profile"
    "$TOOL_BIN" -p "$PROFILE_NIGHT"
fi


