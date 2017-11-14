#!/bin/sh
set -e
set -x

cp -nv /usr/share/doc/util-linux/examples/fstrim.service /etc/systemd/system
cp -nv /usr/share/doc/util-linux/examples/fstrim.timer /etc/systemd/system

systemctl enable fstrim.timer
systemctl status fstrim.timer
