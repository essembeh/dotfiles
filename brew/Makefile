all: brew dupes

install:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

uninstall:
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

cask:
	brew install caskroom/cask/brew-cask
	brew cask install atom

dupes:
	brew tap homebrew/dupes
	brew install grep --with-default-names
	brew install rsync --with-default-names
	brew install diffutils
	brew install gzip
	brew install make

brew:
	brew install coreutils
	brew install findutils --with-default-names
	brew install gnu-indent --with-default-names
	brew install gnu-sed --with-default-names
	brew install gnu-tar --with-default-names
	brew install gnu-which --with-default-names
	brew install vim --override-system-vi
	brew install binutils
	brew install gawk
	brew install watch
	brew install wget
	brew install tmux
	brew install zsh
	brew install git
	brew install nmap
	brew install tmux
	brew install irssi
	brew install lftp
	brew install bvi
	brew install exiftool
	brew install fossil
	brew install moreutils
	brew install rdiff-backup
	brew install mosh
	brew install youtube-dl
	brew install tree
	brew install tig
	brew install gpg
