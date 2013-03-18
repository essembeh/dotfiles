#!/bin/bash
## For local gateway
/sbin/iptables -t nat -A POSTROUTING -s 192.168.42.0/24 -o wlan0 -j MASQUERADE

