
.PHONY: submodules headless desktop apt

LN := ln -nfsv

all: submodules

submodules:
	git submodule sync --recursive
	git submodule update --init --recursive
	
headless: submodules apt/packages.html \
			$(HOME)/.bashrc \
			$(HOME)/.oh-my-zsh \
			$(HOME)/.zshrc \
			$(HOME)/.shell.d \
			$(HOME)/.vim \
			$(HOME)/.tmux.conf \
			$(HOME)/.gitconfig
	if pip3 --version; then \
		pip3 install --upgrade --user \
		 	git+https://github.com/essembeh/pytput \
			git+https://github.com/essembeh/virenamer \
			git+https://github.com/essembeh/ezfuse \
			git+https://github.com/essembeh/RegexTagForMusic \
			bs4 python-Levenshtein youtube-dl ;\
	fi


desktop: headless \
			$(HOME)/.config/mpv \
			$(HOME)/.local/share/applications/xrandr-switch.desktop
	test $(XDG_SESSION_DESKTOP) = "gnome"
	if pip3 --version; then \
		pip3 install --upgrade --user git+https://github.com/essembeh/gnome-extensions-cli && \
		gnome-extensions-cli update --install 1160 1031 15 1465 21 277 1227 841 1319 ;\
	fi
	./gnome3/install-themes.sh
	
apt: apt/packages.html
	test $(shell id -u) -eq 0
	cp -nv apt/preferences.d/seb.pref /etc/apt/preferences.d/
	cp -nv apt/sources.list.d/buster.list /etc/apt/sources.list.d/
	apt update
	
apt/packages.html: apt/packages.xsl apt/packages.xml
	if xsltproc --version; then \
		xsltproc $^ > $@; \
	fi
	
$(HOME)/.bashrc: shell/bashrc
	test -L $(HOME)/.bashrc || mv -nv $(HOME)/.bashrc $(HOME)/.bashrc.orig
	$(LN) $(shell realpath $^) $@

$(HOME)/.oh-my-zsh: submodules/oh-my-zsh
	$(LN) $(shell realpath $^) $@

$(HOME)/.zshrc: shell/zshrc
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.shell.d: shell/shell.d
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.vim: vim
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.lftp: lftp
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.tmux.conf: tmux/tmux.conf
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.gitconfig: git/gitconfig
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.config/mpv: mpv
	mkdir -p $(HOME)/.config
	$(LN) $(shell realpath $^) $@
	
$(HOME)/.local/share/applications/xrandr-switch.desktop: gnome3/xrandr-switch.desktop
	mkdir -p $(HOME)/.local/share/applications/
	$(LN) $(shell realpath $^) $@


