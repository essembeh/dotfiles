#!/bin/sh
set -eux

cp -vn "$(dirname "$0")/rc.local" /etc/rc.local
chmod +x /etc/rc.local
systemctl start rc-local
systemctl status rc-local

