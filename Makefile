.PHONY: submodules pip links desktop

all: submodules links desktop

submodules:
	git submodule sync --recursive
	git submodule update --init --recursive
	touch submodules

pip:
	pip3 install --upgrade --user \
		git+https://github.com/essembeh/pytput \
		git+https://github.com/essembeh/virenamer \
		git+https://github.com/essembeh/ezfuse \
		git+https://github.com/essembeh/RegexTagForMusic \
		git+https://github.com/essembeh/kimsufi-checker \
		bs4 python-Levenshtein \
		youtube-dl

links:
	test -L $(HOME)/.bashrc || mv -nv $(HOME)/.bashrc $(HOME)/.bashrc.orig
	ln -rnfs $(PWD)/submodules/oh-my-zsh $(HOME)/.oh-my-zsh
	ln -rnfs $(PWD)/shell/zshrc $(HOME)/.zshrc
	ln -rnfs $(PWD)/shell/bashrc $(HOME)/.bashrc
	ln -rnfs $(PWD)/shell/shell.d $(HOME)/.shell.d
	ln -rnfs $(PWD)/git/gitconfig $(HOME)/.gitconfig
	ln -rnfs $(PWD)/tmux/tmux.conf $(HOME)/.tmux.conf
	ln -rnfs $(PWD)/vim $(HOME)/.vim
	ln -rnfs $(PWD)/lftp $(HOME)/.lftp

desktop:
	mkdir -p $(HOME)/.config/ $(PWD)/.local/share/applications/ 
	ln -rnfs $(PWD)/mpv $(HOME)/.config/mpv
	ln -rnfs $(PWD)/xrandr/xrandr-switch.desktop $(HOME)/.local/share/applications/
	./gnome3/install-themes.sh
