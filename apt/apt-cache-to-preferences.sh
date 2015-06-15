#!/bin/bash

__getValue () {
	attribute=$1
	letter=$2

	value="`cat $releaseFile | tr -d "\r" | egrep "^$attribute: " | sed -r -e "s/^.*?: //"`"
	printf "%s=%s" "$letter" "$value"
}


echo "Package: *"
echo "Pin: release o=apt-build"
echo "Pin-Priority: 900"
echo 
echo 

for releaseFile in /var/lib/apt/lists/*Release; do 
	echo "; `basename $releaseFile`"
	echo "Package: *"
	printf "Pin: release %s, %s, %s, %s\n" \
		"`__getValue "Suite" "a"`" \
		"`__getValue "Codename" "n"`" \
		"`__getValue "Origin" "o"`" \
		"`__getValue "Label" "l"`"
	echo "Pin-Priority: 400"
	echo
done
