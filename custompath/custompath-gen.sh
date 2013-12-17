#!/bin/bash


CUSTOMPATH_EXPORT=".CUSTOMPATH"

echo -n "export PATH=\$PATH"
find ~ -name "$CUSTOMPATH_EXPORT" -type f -print | while read LINE; do 
	echo -n ":`dirname "$LINE"`"
done
echo "" 

