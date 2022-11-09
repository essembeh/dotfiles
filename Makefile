
LN := ln -nfsv

.PHONY: all init install submodules 

all: submodules

install: submodules
	test -f $(HOME)/.bashrc && mv -nv $(HOME)/.bashrc $(HOME)/.bashrc.orig || true
	$(LN) $(PWD)/shell/bashrc $(HOME)/.bashrc
	$(LN) $(PWD)/shell/zshrc $(HOME)/.zshrc
	$(LN) $(PWD)/shell/shell.d $(HOME)/.shell.d
	$(LN) $(PWD)/submodules/ohmyzsh $(HOME)/.ohmyzsh
	$(LN) $(PWD)/vim $(HOME)/.vim
	$(LN) $(PWD)/lftp $(HOME)/.lftp
	$(LN) $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	$(LN) $(PWD)/git/gitconfig $(HOME)/.gitconfig
	mkdir -vp $(HOME)/.config 
	$(LN) $(PWD)/mpv $(HOME)/.config/mpv

init: submodules
	which zsh || (sudo apt update && sudo apt install zsh git tig tmux vim vim-pathogen rsync python3-pip python3-venv)
	test -n "$(ZSH)" || chsh --shell /bin/zsh

submodules:
	git submodule sync --recursive
	git submodule update --init --recursive --depth 10
