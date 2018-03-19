#!/bin/sh
set -e

__ln () {
	if test -L "$2"; then
		echo "$2 is already linked"
	elif test -e "$2"; then
		echo "$2 already exists"
	else
		ln -vs "$1" "$2"
	fi
}

__createCustomLinks () {
	local PREFIX="$HOME/$1"; shift
	while test -n "$1"; do
		local SOURCE="`pwd`/$1"
		local DESTINATION="$PREFIX`basename "$SOURCE"`"
		mkdir -p "`dirname "$DESTINATION"`"
		__ln "$SOURCE" "$DESTINATION"
		shift
	done
}

cd `dirname "$0"`

git submodule sync --recursive
git submodule update --init --recursive

__createCustomLinks "." \
	submodules/oh-my-zsh \
	shell/bashrc shell/alias shell/profile shell/custompath shell/zshrc shell/zshenv \
	git/gitconfig tmux/tmux.conf vim lftp 
__createCustomLinks ".config/" \
	mpv
__createCustomLinks ".themes/" \
	submodules/OSX-Arc-Darker 
__createCustomLinks ".local/share/gnome-shell/" \
	gnome3/extensions

