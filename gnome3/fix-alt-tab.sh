#!/usr/bin/env bash
#
# fix-alt-tab - restore a "GNOME 2 style" Alt-Tab
#
#   Super-Tab : switch between applications (grouped)
#   Alt-Tab   : switch between ALL windows, across ALL workspaces
#

set -euo pipefail

gsettings set org.gnome.desktop.wm.keybindings switch-applications          "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows               "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward      "['<Shift><Alt>Tab']"
gsettings set org.gnome.shell.window-switcher  current-workspace-only       false

echo "Alt-Tab OK: Super=apps, Alt=windows (all workspaces)"
