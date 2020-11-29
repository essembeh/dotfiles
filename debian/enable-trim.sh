#!/bin/sh
set -eux

SOURCE=/lib/systemd/system
test -d "$SOURCE"

cp -nv $SOURCE/fstrim.service /etc/systemd/system
cp -nv $SOURCE/fstrim.timer /etc/systemd/system

systemctl enable fstrim.timer
systemctl status fstrim.timer
