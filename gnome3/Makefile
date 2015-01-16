all: 

gnome3.4: 
	gsettings set org.gnome.shell.overrides button-layout 'close,maximize,minimize:'
	gsettings get org.gnome.shell.overrides button-layout

gnome3.14:
	gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:'
	gsettings get org.gnome.desktop.wm.preferences button-layout
	gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "{'Gtk/ButtonImages': <1>, 'Gtk/MenuImages': <1>}"
	gsettings get org.gnome.settings-daemon.plugins.xsettings overrides 

