# Disable GDM auto suspend

```sh
# login as gdm
su - gdm -s /bin/sh

# once logged as gdm
export $(dbus-launch)
GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.session idle-delay 0

```
