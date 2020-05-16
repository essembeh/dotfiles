#!/bin/sh
set -eux

gnome-extensions-cli --version

## Mandatory
# https://extensions.gnome.org/extension/1160/dash-to-panel/
# https://extensions.gnome.org/extension/1031/topicons/
# https://extensions.gnome.org/extension/15/alternatetab/
# https://extensions.gnome.org/extension/1465/desktop-icons/
# https://extensions.gnome.org/extension/21/workspace-indicator/
# https://extensions.gnome.org/extension/277/impatience/
# https://extensions.gnome.org/extension/1227/window-corner-preview/
# https://extensions.gnome.org/extension/690/easyscreencast/
# https://extensions.gnome.org/extension/841/freon/
# https://extensions.gnome.org/extension/771/proxy-switcher/

gnome-extensions-cli update --install \
    1160 1031 15 1465 21 277 1227 690 841

