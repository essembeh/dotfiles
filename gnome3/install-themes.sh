#!/bin/bash
set -eu

cd "$(dirname "$0")/themes"
mkdir -p "$HOME/.themes"
for ARCHIVE in *; do
	test -f "$ARCHIVE"
	NAME=$(tar fat "$ARCHIVE" | awk -F '/' '{print $1}' | sort -u)
	if test "$(echo "$NAME" | wc -l)" -eq 1; then
		DEST="$HOME/.themes/$NAME"
		if test -d "$DEST"; then
			echo "Theme already installed $DEST"
			mv -nv "$DEST" "/tmp/$NAME.$RANDOM"
		fi
		echo "Install theme $ARCHIVE in $DEST"
		tar -C "$HOME/.themes" -xaf "$ARCHIVE"
	else
		echo "Invalid archive $ARCHIVE"
	fi
done

