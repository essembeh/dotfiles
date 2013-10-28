#!/bin/bash


if ! test -d "$1"; then
	echo "Usage: $0 /path/to/yout/chroot/"
	exit 1
fi

DEST="`echo "$1" | sed "s/\\/$//"`"
printf "## chroot folder: %s\n" "$DEST"
printf "proc            %s/proc       proc    defaults        0       2\n" "$DEST"
printf "sys             %s/sys        sysfs   defaults        0       2\n" "$DEST"
printf "/dev            %s/dev        none    bind            0       2\n" "$DEST"
printf "/dev/pts        %s/dev/pts    auto    bind            0       2\n" "$DEST"
printf "/var/run        %s/var/run    none    bind            0       2\n" "$DEST"
printf "/home           %s/home       none    bind            0       2\n" "$DEST"
printf "/tmp            %s/tmp        none    bind            0       2\n" "$DEST"

