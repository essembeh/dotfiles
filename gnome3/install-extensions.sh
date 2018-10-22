#!/bin/bash
set -eu

__yn() {
	local YN=""	
	while test "$YN" != "y" -a "$YN" != "n"; do
		echo "$1 (y/n)?"
		read YN
	done
	test "$YN" = "y"
}

TARGET="$HOME/.local/share/gnome-shell/extensions"
cd "$(dirname "$0")/extensions"
mkdir -p "$TARGET"
for FILE in *.shell-extension.zip; do
	test -f "$FILE"
	NAMESPACE=$(unzip -p "$FILE" metadata.json | awk -F '"' '/"uuid": / {print $4}')
	FOLDER="$TARGET/$NAMESPACE"
	if ! test -d "$FOLDER"; then
		if __yn "Installing $NAMESPACE from $FILE?"; then
			mkdir "$TARGET/$NAMESPACE"
			unzip -q -d "$TARGET/$NAMESPACE" "$FILE"
			gnome-shell-extension-tool -e "$NAMESPACE" || true
		fi
	fi
done
echo "You should run ALT+F2 then 'r' to restart Gnome Shell"
