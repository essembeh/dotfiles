#!/bin/sh
set -u

FILENAME="%(upload_date)s %(title)s.%(ext)s"

for FILE in "$@"; do 
	if test -f "$FILE"; then
		WORKDIR=$(dirname "$FILE")
		grep -v '^#' "$FILE" | while read -r SUBFOLDER URL EXTRA_ARGS; do
            yt-dlp --continue --ignore-errors --no-overwrites \
                   --format 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' \
                   --download-archive "${WORKDIR}/${SUBFOLDER}/.done.txt" \
                   --output "$WORKDIR/$SUBFOLDER/$FILENAME" \
                   $EXTRA_ARGS \
                   "$URL"
            touch "$WORKDIR/$SUBFOLDER"
		done
	fi
done
