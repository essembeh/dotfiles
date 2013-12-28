#!/bin/bash

TARGET=~/.local/share/applications

if [ ! -d $TARGET ]; then
	mkdir -p $TARGET
fi

if [ ! -f $TARGET/defaults.list ]; then
	echo "[Default Applications]" >> $TARGET/defaults.list
fi
echo "cat mimeinfo.data >> $TARGET/defaults.list"
      cat mimeinfo.data >> $TARGET/defaults.list


if [ ! -f $TARGET/mimeinfo.cache ]; then
        echo "[MIME Cache]" >> $TARGET/mimeinfo.cache
fi
echo "cat mimeinfo.data >> $TARGET/mimeinfo.cache"
      cat mimeinfo.data >> $TARGET/mimeinfo.cache


echo "cp mplayer-nogui.desktop $TARGET"
      cp mplayer-nogui.desktop $TARGET 
