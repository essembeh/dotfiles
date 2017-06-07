#!/bin/sh -e

start-stop-daemon \
	--start \
	--oknodo \
	--umask 077 \
	--user seb \
	--name syncthing \
	--pidfile /var/run/syncthing.pid \
	--startas /usr/bin/syncthing \
	--chuid seb \
	--background \
	-- --no-browser

