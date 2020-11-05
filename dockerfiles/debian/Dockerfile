FROM debian:latest
MAINTAINER Sébastien M-B <seb@essembeh.org>

## base packages
RUN apt-get -q update
RUN apt-get install -y -q \
	locales bash-completion curl wget file man manpages sudo make \
	zsh python3-pip tmux git vim vim-pathogen vim-syntastic tig lftp tree coreutils moreutils p7zip-full rsync borgbackup \
	&& apt-get clean

## devel packages
#RUN apt-get install -y -q build-essential && apt-get clean

## locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8

## new user
RUN useradd -d /home/seb -m -s /bin/zsh -u 1000 seb
RUN echo "seb ALL = NOPASSWD: ALL" >> /etc/sudoers
USER seb
WORKDIR /home/seb
RUN git clone https://github.com/essembeh/dotfiles
RUN cd dotfiles && make headless

# entrypoint
CMD ["/bin/zsh"]
