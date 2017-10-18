#!/bin/sh

set -e

cp -v /usr/share/doc/util-linux/examples/fstrim.service /etc/systemd/system
cp -v /usr/share/doc/util-linux/examples/fstrim.timer /etc/systemd/system

systemctl enable fstrim.timer
systemctl status fstrim.timer
