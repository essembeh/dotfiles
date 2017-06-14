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

__createConfigLinks () {
	while test -n "$1"; do
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
__createHomeLinks bash/bashrc bash/alias bash/profile bash/custompath
__createHomeLinks zsh/zshrc zsh/zshenv
__createHomeLinks git/gitconfig
__createHomeLinks tmux/tmux.conf
__createHomeLinks vim
__createHomeLinks lftp
__createConfigLinks mpv
