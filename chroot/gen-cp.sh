#!/bin/bash


if ! test -d "$1"; then
	echo "Usage: $0 /path/to/yout/chroot/"
	exit 1
fi

DEST="`echo "$1" | sed "s/\\/$//"`"
for FILE in /etc/passwd /etc/shadow /etc/group /etc/sudoers /etc/hosts /etc/hostname; do
	printf "cp %s  %s%s/\n" "$FILE" "$DEST" "`dirname "$FILE"`"
done

