FROM debian:jessie
MAINTAINER Sébastien M-B <essembeh@gmail.com>

## Base packages
ADD https://raw.githubusercontent.com/essembeh/dotfiles/master/apt/debian/jessie.list /etc/apt/sources.list
RUN apt-get -q update
RUN apt-get install -y -q \
	locales bash-completion curl wget file man manpages sudo \
	&& apt-get clean
RUN apt-get install -y -q \
	zsh tmux git vim tig lftp tree moreutils realpath p7zip-full rsync rdiff-backup \
	&& apt-get clean

## Devel packages
#RUN apt-get install -y -q build-essential && apt-get clean

## Locale
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=fr_FR.UTF-8
ENV LANGUAGE fr_FR.UTF-8
ENV LANG fr_FR.UTF-8
ENV LC_ALL fr_FR.UTF-8

## Default shell
RUN chsh root -s /bin/zsh

## New user
RUN useradd -d /home/seb -m -s /bin/zsh -u 1000 seb
RUN echo "seb ALL = NOPASSWD: ALL" >> /etc/sudoers

## User custom
USER seb
WORKDIR /home/seb
RUN git clone https://github.com/essembeh/dotfiles
RUN ./dotfiles/setup.sh
RUN sudo ln -s /home/seb/dotfiles /root/dotfiles
RUN sudo /root/dotfiles/setup.sh

CMD ["/bin/zsh"]
