#!/bin/sh
set -eu

## Raid status
if test -f /proc/mdstat && grep -E -q "^md[0-9]+" /proc/mdstat; then
	echo "============================  Raid Status  ================================"
	grep -E --color -A1 "^md[0-9]+" /proc/mdstat
	echo "==========================================================================="
fi
