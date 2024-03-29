# use sudo if user not in docker group but in sude group
if $(id | fgrep -vq '(docker)') && $(id | fgrep -q '(sudo)'); then
    alias docker="sudo docker"
fi

alias dcu="dc up -d --remove-orphans"
alias dcd="dc down --volumes --remove-orphans"
alias dcl="dc logs --follow --tail=1"

function dorun {
    docker run --rm -t -i \
		--volume "$HOME:/target/home:ro" \
		--volume /tmp:/target/tmp \
		--volume "$PWD:/target/pwd" \
		--workdir /target/pwd \
		"$@"
}

function dorunX {
    dorun \
		--volume /tmp/.X11-unix:/tmp/.X11-unix \
		--env DISPLAY \
		"$@"
}
