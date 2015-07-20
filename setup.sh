#!/bin/bash
set -e

function createLinks {
  while test -n "$1"; do
    local SOURCE="$ROOT/$1"
    local DESTINATION="$HOME/.`basename "$SOURCE"`"

    if test -L "$DESTINATION"; then
      echo "$DESTINATION is already linked"
    elif test -e "$DESTINATION"; then
      echo "$DESTINATION already exists"
    else
      ln -vs "$SOURCE" "$DESTINATION"
    fi
    shift
  done
}


ROOT=`dirname "$0"`
[[ ! "$ROOT" = /* ]] && ROOT="$PWD/$ROOT"

(cd "$ROOT" && git submodule sync --recursive && git submodule update --init --recursive)

createLinks 3rdparty/oh-my-zsh
createLinks bash/bashrc bash/alias bash/profile bash/custompath
createLinks zsh/zshrc zsh/zshenv
createLinks git/gitconfig
createLinks tmux/tmux.conf
createLinks vim
createLinks lftp
