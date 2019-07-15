#!/bin/sh

for ETH in /sys/class/net/*; do
	if ! test "$ETH" = "/sys/class/net/lo"; then
		echo "----- $ETH -----"
		udevadm test-builtin net_id $ETH 2>/dev/null
		echo ""
	fi
done

