#!/bin/bash
set -eu

for FILE in "$@"; do
	echo "----------[$FILE]----------"
	if test -f "$FILE"; then
		# Create a uniq target folder for extraction
		FILENAME="$(basename "$FILE")"
		WORKDIR="./$FILENAME.d"
		while test -e "$WORKDIR"; do
			WORKDIR="./$FILENAME.$RANDOM"
		done
		mkdir -v "$WORKDIR"
		# Extract file using tar or 7z
		case "$FILENAME" in
			*.tar|*.tar.*|*.tgz)
				tar -C "$WORKDIR" -xavf "$FILE"
				;;
			*)
				7z x -o"$WORKDIR" "$FILE"
				;;
		esac
		# Check if archive only contains one folder/file
		CONTENT=$(ls -A1 "$WORKDIR" 2>/dev/null)
		if test "$(echo "$CONTENT" | wc -l)" = "1"; then
			if ! test -e "./$CONTENT"; then
				mv -nv "$WORKDIR/$CONTENT" "./$CONTENT"
				rmdir -v "$WORKDIR"
			fi
		else
			# Try to rename the target folder
			TARGET="./${FILENAME%.*}"
			if [[ $FILENAME == *.tar.* ]]; then
				TARGET="./${FILENAME%.tar.*}"
			fi
			if ! test -e "$TARGET"; then
				mv -nv "$WORKDIR" "$TARGET"
			fi
		fi
	fi
	echo ""
done

