# Theme with full path names and hostname
# Handy if you work on different servers all the time;


local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"

function my_git_prompt_info() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || return
	GIT_STATUS=$(git_prompt_status)
	[[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$GIT_STATUS$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Colored prompt
local ZSH_PROMPT_CHROOT=""
test -z "${debian_chroot:-}" && test -r /etc/debian_chroot && \
	ZSH_PROMPT_CHROOT="%{%b$fg[yellow]%}(`cat /etc/debian_chroot`)%{$reset_color%} "
local ZSH_THEME_COLOR_HOST="green"
test -n "$SSH_CONNECTION" && ZSH_THEME_COLOR_HOST="red"
test `id -u` = 0 && ZSH_THEME_COLOR_HOST="magenta"
local ZSH_PROMPT_HOST="%{$fg[$ZSH_THEME_COLOR_HOST]%}%n@%M%{$reset_color%}"
local ZSH_PROMPT_PWD="%{%B$fg[yellow]%}%~%{$reset_color%}"
PROMPT='$ZSH_PROMPT_CHROOT$ZSH_PROMPT_HOST:$ZSH_PROMPT_PWD $(my_git_prompt_info)%(!.#.$) '
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%%"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

