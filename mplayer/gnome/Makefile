all: mplayer.desktop
	mkdir -p ${HOME}/.local/share/applications/
	cp mplayer.desktop ${HOME}/.local/share/applications/
	cat /usr/share/applications/mimeinfo.cache | fgrep "org.gnome.Totem.desktop" | sed "s/org.gnome.Totem.desktop/mplayer.desktop/" > ${HOME}/.local/share/applications/mimeinfo.cache
