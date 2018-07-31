#!/bin/bash
set -eu

TARGET="$HOME/.local/share/gnome-shell/extensions"
cd "$(dirname "$0")/extensions"
mkdir -p "$TARGET"
for FILE in *.shell-extension.zip; do
	YN=""
	test -f "$FILE"
	NAMESPACE=$(unzip -p "$FILE" metadata.json | awk -F '"' '/"uuid": / {print $4}')
	FOLDER="$TARGET/$NAMESPACE"
	if test -d "$FOLDER"; then
		echo "Extension already installed $NAMESPACE, reinstall?"
		read YN
		if test "$YN" = "y"; then
			rm -r "$FOLDER"
		fi
	fi
	if ! test -d "$FOLDER"; then
		echo "Installing $NAMESPACE from $FILE?"
		read YN
		if test "$YN" = "y"; then
			mkdir "$TARGET/$NAMESPACE"
			unzip -q -d "$TARGET/$NAMESPACE" "$FILE"
			echo "Enable extension?"
			read YN
			if test "$YN" = "y"; then
				gnome-shell-extension-tool -e "$NAMESPACE" || true
			fi
		fi
	fi
done

