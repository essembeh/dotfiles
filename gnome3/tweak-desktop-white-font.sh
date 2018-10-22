#!/bin/sh
set -eux

mkdir -p "${HOME}/.config/gtk-3.0/"
cat > "$HOME/.config/gtk-3.0/gtk.css2" << EOF
.nautilus-desktop.nautilus-canvas-item {
  color: white;
  text-shadow: 1px 1px grey;
}
EOF

