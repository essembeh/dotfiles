#!/bin/bash
## To allow OpenVpn to access lan
/sbin/iptables -t nat -A POSTROUTING -s 10.8.1.0/24 -o eth0 -j MASQUERADE
/sbin/iptables -t nat -A POSTROUTING -s 10.8.2.0/24 -o eth0 -j MASQUERADE
