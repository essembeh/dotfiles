
LN := ln -nfsv

.PHONY: submodules headless desktop apt

all: submodules

submodules:
	git submodule sync --recursive
	git submodule update --init --recursive

headless: submodules
	test -L $(HOME)/.bashrc || mv -nv $(HOME)/.bashrc $(HOME)/.bashrc.orig
	$(LN) $(PWD)/shell/bashrc $(HOME)/.bashrc
	$(LN) $(PWD)/shell/zshrc $(HOME)/.zshrc
	$(LN) $(PWD)/shell/shell.d $(HOME)/.shell.d
	$(LN) $(PWD)/submodules/oh-my-zsh $(HOME)/.oh-my-zsh
	$(LN) $(PWD)/vim $(HOME)/.vim
	$(LN) $(PWD)/lftp $(HOME)/.lftp
	$(LN) $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	$(LN) $(PWD)/git/gitconfig $(HOME)/.gitconfig

desktop: headless apps
	mkdir -p $(HOME)/.config $(HOME)/.local/share/applications
	$(LN) $(PWD)/mpv $(HOME)/.config/mpv
	$(LN) $(PWD)/gnome3/xrandr-switch.desktop $(HOME)/.local/share/applications/xrandr-switch.desktop
	./gnome3/install-themes.sh
	gnome-extensions-cli update --install 1160 1031 15 1465 21 277 1227 841 1319

apps:
	pip3 install -U --user \
		pip bs4 python-Levenshtein youtube-dl
	pip3 install -U --user \
		git+https://github.com/essembeh/virenamer \
		git+https://github.com/essembeh/ezfuse \
		git+https://github.com/essembeh/photomatools \
		git+https://github.com/essembeh/gnome-extensions-cli

apt: apt/packages.xsl apt/packages.xml
	sudo apt update
	sudo apt install zsh git tig tmux vim vim-pathogen rsync xsltproc python3-pip
	xsltproc $^ > apt/packages.html
