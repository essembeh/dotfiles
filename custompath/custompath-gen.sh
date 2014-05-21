#!/bin/bash


CUSTOMPATH_EXPORT=".CUSTOMPATH"



find "$PWD" -name "$CUSTOMPATH_EXPORT" -type f -print 2> /dev/null | while read LINE; do
	echo "`dirname "$LINE"`"
done
