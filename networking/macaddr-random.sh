#!/bin/bash

__usage () {
	echo "NAME
	macaddr-random - Tool to generate random MAC address

DESCRIPTION
	THIS SCRIPT DOEST NOT CHANGE YOUR MAC ADDRESS DIRECTLY!
	IT ONLY DISPLAYS RANDOM MAC ADDRESS AND COMMANDS TO CHANGE IT. 

	This script generates random MAC addresses.  You can specify a prefix.
	See examples to see how you can use this script to change your MAC address
	using pipe, xargs and sudo.

USAGE
	macaddr-random
	macaddr-random -u -d
	macaddr-random --iface eth0 
	macaddr-random --iface eth0 --prefix aa:bb:cc:dd
	macaddr-random --iface en0 --macos

OPTIONS
	-h, --help
		Diplay this message.

	-u, --upper
		Prints letters uppercase
	
	-d, --dash
		Uses - as separator instead of :
	
	-p <PREFIX>, --prefix <PREFIX>
		Uses PREFIX as prefix for MAC address.
		Note: if prefix is xx:xx:xx:xx:xx:xx, the output MAC address
		will be the prefix itself

	-i <IFACE>, --iface <IFACE>
		Prints the ifconfig command to set the MAC address for given IFACE
	
	--macos
		Prints the MacOS ifconfig command

EXAMPLES
	macaddr-random -i eth0 -p aa:bb:cc | xargs sudo
"		
}

OPTION_UPPER=false
OPTION_DASH=false
OPTION_PREFIX=
OPTION_OS="linux"

while test -n "$1"; do
	case $1 in
		--help|-h) __usage; exit 0;;
		-u|--upper) OPTION_UPPER=true ;;
		-d|--dash) OPTION_DASH=true ;;
		-p|--prefix) shift; OPTION_PREFIX="$1" ;;
		-i|--iface) shift; OPTION_IFACE="$1" ;;
		--macos) OPTION_OS="macos" ;;
		*) break;;
	esac
	shift
done

RANDOM_ADDRESS=$(printf "%x%x:%x%x:%x%x:%x%x:%x%x:%x%x" \
	"$(($RANDOM %8 *2))" "$(($RANDOM %16))" \
	"$(($RANDOM %16))" "$(($RANDOM %16))" \
	"$(($RANDOM %16))" "$(($RANDOM %16))" \
	"$(($RANDOM %16))" "$(($RANDOM %16))" \
	"$(($RANDOM %16))" "$(($RANDOM %16))" \
	"$(($RANDOM %16))" "$(($RANDOM %16))")

if test -n "$OPTION_PREFIX"; then
	PREFIX_LENGTH=$(expr length "$OPTION_PREFIX")
	RANDOM_ADDRESS="$OPTION_PREFIX${RANDOM_ADDRESS:$PREFIX_LENGTH}"
fi
test "$OPTION_UPPER" = "true" && RANDOM_ADDRESS=$(echo -n "$RANDOM_ADDRESS" | tr 'abcdef' 'ABCDEF')
test "$OPTION_DASH" = "true" && RANDOM_ADDRESS=$(echo -n "$RANDOM_ADDRESS" | tr ':' '-')

if test -z "$OPTION_IFACE"; then
	echo "$RANDOM_ADDRESS"	
else
	case "$OPTION_OS" in
		"macos")
			echo "ifconfig $OPTION_IFACE ether $RANDOM_ADDRESS" ;;
		"linux")
			echo "ifconfig $OPTION_IFACE hw ether $RANDOM_ADDRESS" ;;
	esac
fi

