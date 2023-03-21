#!/bin/sh
set -eu

FILENAME="%(title)s.%(ext)s"

for FILE in "$@"; do 
	if test -f "${FILE}"; then
		WORKDIR=$(dirname "${FILE}")
		grep -v '^#' "${FILE}" | while read -r SUBFOLDER CHANNEL SHOWID ALT_FILENAME; do
            if [ -z "$ALT_FILENAME" ]; then
                ALT_FILENAME="$FILENAME"
            fi
            curl --silent "https://www.france.tv/$CHANNEL/$SHOWID/" \
                | grep -E -o "/$CHANNEL/$SHOWID/[^\"]+html" \
                | sort -u \
                | sed "s@^@https://www.france.tv@" \
                | yt-dlp --continue --ignore-errors --no-overwrites \
                         --download-archive "$WORKDIR/$SUBFOLDER/.done.txt" \
                         --output "$WORKDIR/$SUBFOLDER/$ALT_FILENAME" \
                         --batch-file -
            touch "$WORKDIR/$SUBFOLDER"
		done
	fi
done
