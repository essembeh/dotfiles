#!/bin/sh
set -eu

ROOT=$(dirname "$0")
REPO_URL="https://github.com/MatMoul/g810-led"
SRC_DIR="$ROOT/g810-led"

echo "🧲 Fetch $REPO_URL -> $SRC_DIR ..."
if [ -d "$SRC_DIR" ]; then
    git -C "$SRC_DIR" pull
else
    git clone "$REPO_URL" "$SRC_DIR"
fi

echo "⏳ Build $SRC_DIR ..."
nix-shell -p hidapi gnumake --run "cd \"$SRC_DIR\" && make clean all"

echo "🚥 Set profile"
test -x "$SRC_DIR/bin/g810-led"
"$SRC_DIR/bin/g810-led" -p "$ROOT/g810-light.profile"

