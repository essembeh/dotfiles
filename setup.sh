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

__createThemesLinks () {
	while test -n "$1"; do
		mkdir -p "$HOME/.themes"
		local SOURCE="`pwd`/$1"
		local DESTINATION="$HOME/.themes/`basename "$SOURCE"`"
		__ln "$SOURCE" "$DESTINATION"
		shift
	done
}

__createConfigLinks () {
	while test -n "$1"; do
		mkdir -p "$HOME/.config"
		local SOURCE="`pwd`/$1"
		local DESTINATION="$HOME/.config/`basename "$SOURCE"`"
		__ln "$SOURCE" "$DESTINATION"
		shift
	done
}

__createHomeLinks () {
	while test -n "$1"; do
		local SOURCE="`pwd`/$1"
		local DESTINATION="$HOME/.`basename "$SOURCE"`"
		__ln "$SOURCE" "$DESTINATION"
		shift
	done
}

cd `dirname "$0"`

git submodule sync --recursive
git submodule update --init --recursive

__createHomeLinks submodules/oh-my-zsh
__createHomeLinks shell/bashrc shell/alias shell/profile shell/custompath
__createHomeLinks shell/zshrc shell/zshenv
__createHomeLinks git/gitconfig
__createHomeLinks tmux/tmux.conf
__createHomeLinks vim
__createHomeLinks lftp
__createConfigLinks mpv

if [ `uname -s` = "Linux" ]; then
	__createThemesLinks submodules/OSX-Arc-Darker submodules/OSX-Arc-Plus submodules/OSX-Arc-Shadow submodules/OSX-Arc-White
fi
