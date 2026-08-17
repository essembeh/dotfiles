#!/usr/bin/env bash
#
# Symlinks this repo's dotfiles into the current user's home directory.
# Idempotent: an already-correct link is left untouched. An existing symlink
# (even pointing elsewhere) is overwritten. A real file is backed up to *.orig
# (.orig.1, .orig.2... if already taken) before the link is created.
#
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Map "source path in repo" -> "target name in home"
declare -A LINKS=(
	["shell/zshrc"]=".zshrc"
	["shell/zshenv"]=".zshenv"
	["tmux/tmux.conf"]=".tmux.conf"
	["vim/vimrc"]=".vimrc"
	["git/gitconfig"]=".gitconfig"
)

link_one() {
	local src="$REPO_DIR/$1"
	local dst="$HOME/$2"

	if [[ ! -e "$src" ]]; then
		echo "[SKIP] missing source: $src"
		return
	fi

	# Already the correct link
	if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
		echo "[OK]   $dst -> $src"
		return
	fi

	if [[ -L "$dst" ]]; then
		# Existing symlink pointing elsewhere: overwrite without backup
		echo "[DEL]  stale link $dst"
		rm "$dst"
	elif [[ -e "$dst" ]]; then
		# Real file: back up to .orig (.orig.1, .orig.2... if already taken)
		local bak="$dst.orig"
		local i=1
		while [[ -e "$bak" ]]; do
			bak="$dst.orig.$i"
			i=$((i + 1))
		done
		echo "[BAK]  $dst -> $bak"
		mv "$dst" "$bak"
	fi

	ln -s "$src" "$dst"
	echo "[LINK] $dst -> $src"
}

for src in "${!LINKS[@]}"; do
	link_one "$src" "${LINKS[$src]}"
done
