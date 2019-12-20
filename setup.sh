#!/bin/bash
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
		local SOURCE
		SOURCE="$PWD/$1"
		local DESTINATION
		DESTINATION=$PREFIX$(basename "$SOURCE")
		mkdir -p "$(dirname "$DESTINATION")"
		__ln "$SOURCE" "$DESTINATION"
		shift
	done
}

cd "$(dirname "$0")"

git submodule sync --recursive
git submodule update --init --recursive

# Handle .bashrc overide
if ! test -L $HOME/.bashrc; then
	mv -nv $HOME/.bashrc{,.orig}
fi

__createCustomLinks "." \
	submodules/oh-my-zsh \
	shell/zshrc shell/bashrc shell/shell.d \
	git/gitconfig tmux/tmux.conf vim lftp \
	
__createCustomLinks ".config/" \
	mpv

if test -x /usr/bin/pip3; then
	pip3 install --upgrade --user \
		git+https://github.com/essembeh/pytput \
		git+https://github.com/essembeh/virenamer \
		git+https://github.com/essembeh/ezfuse \
		git+https://github.com/essembeh/RegexTagForMusic \
		git+https://github.com/essembeh/kimsufi-checker \
		bs4 python-Levenshtein \
		youtube-dl
fi
