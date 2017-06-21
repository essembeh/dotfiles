#!/bin/sh

set -e
set -x 

mkdir -p ${HOME}/.config/gtk-3.0/
cp -n "$(dirname "$0")/gtk.css" ${HOME}/.config/gtk-3.0/

