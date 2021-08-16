#!/bin/bash

__getValue () {
	echo "$3=$(tr -d "\r" < "$1" | grep -E "^$2: " | sed -r -e "s/^.*?: //")"
}


echo "Package: *"
echo "Pin: release o=apt-build"
echo "Pin-Priority: 900"
echo ""
echo ""

for releaseFile in /var/lib/apt/lists/*Release; do 
	echo "; From file: $releaseFile"
	echo "Package: *"
	printf "Pin: release %s, %s, %s, %s\n" \
		"$(__getValue "$releaseFile" "Suite" "a")" \
		"$(__getValue "$releaseFile" "Codename" "n")" \
		"$(__getValue "$releaseFile" "Origin" "o")" \
		"$(__getValue "$releaseFile" "Label" "l")"
	echo "Pin-Priority: 500"
	echo ""
done
