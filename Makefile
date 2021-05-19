
LN := ln -nfsv

.PHONY: submodules headless desktop apps install

all: submodules

install: submodules
	which zsh || (sudo apt update && sudo apt install zsh git tig tmux vim vim-pathogen rsync python3-pip python3-venv)
	test -n "$(ZSH)" || chsh --shell /bin/zsh

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

desktop: headless
	mkdir -p $(HOME)/.config 
	$(LN) $(PWD)/mpv $(HOME)/.config/mpv
	./gnome3/install-themes.sh
	if test "$(XDG_CURRENT_DESKTOP)" = "GNOME"; then \
		pip3 install --user --upgrade git+https://github.com/essembeh/gnome-extensions-cli && \
		grep "^[^#]" gnome3/extensions.txt | xargs $(HOME)/.local/bin/gnome-extensions-cli update --install ;\
	fi

apps:
	pip3 install --user --upgrade pipx
	pip3 install --user --upgrade bs4 python-Levenshtein colorama
	$(HOME)/.local/bin/pipx install -f poetry
	$(HOME)/.local/bin/pipx install -f youtube-dl
	$(HOME)/.local/bin/pipx install -f git+https://github.com/essembeh/virenamer
	$(HOME)/.local/bin/pipx install -f git+https://github.com/essembeh/ezfuse
	$(HOME)/.local/bin/pipx install -f git+https://github.com/essembeh/borg-find
