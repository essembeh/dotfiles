#!/bin/bash

MGIT_PAGER="less -r"
MGIT_CONF="./mgit.conf"
MGIT_LIST="conf"
MGIT_QUIET="false"

GIT="/usr/bin/git"

function customOut {
	while test $# -gt 0; do 
		case $1 in
			black)       tput setaf 0;;
			red)         tput setaf 1;;
			green) 	     tput setaf 2;;
			yellow)      tput setaf 3;;
			blue)        tput setaf 4;;
			purple)      tput setaf 5;;
			cyan)        tput setaf 6;;
			white) 	     tput setaf 7;;
			back-black)  tput setab 0;;
			back-red)    tput setab 1;;
			back-green)  tput setab 2;;
			back-yellow) tput setab 3;;
			back-blue)   tput setab 4;;
			back-purple) tput setab 5;;
			back-cyan)   tput setab 6;;
			back-white)  tput setab 7;;
			bold)        tput bold;;
			halfbright)  tput dim;;
			underline)   tput smul;;
			nounderline) tput rmul;;
			reverse)     tput rev;;
			standout)    tput smso;;
			nostandout)  tput rmso;;
			reset)       tput sgr0;;
			*)           tput sgr0;;
		esac
		shift
	done
}

function fillLine {
	ITEM="$1"
	if test -z "$ITEM"; then
		echo ""
	else
		WIDTH=$(tput cols)
		ITEMLEN=$(printf "%s" "$ITEM" | wc -m)
		if test "$ITEMLEN" -gt "$WIDTH"; then 
			printf "%s\n" "$ITEM"
		else 
			COUNT=$((WIDTH / ITEMLEN))
			for I in $(seq 1 $COUNT); do
				printf "%s" "$ITEM"
			done
			printf "\n"
		fi
	fi
}

function main {
	if test "$MGIT_LIST" = "conf" && test -f "$MGIT_CONF"; then
		LIST=$(cat "$MGIT_CONF")
	else
		LIST=$(find -L . -mindepth 2 -maxdepth 2 -name ".git" -exec dirname {} \; | sort)
	fi 
	if test -z "$LIST"; then
		customOut red bold back-white
		echo "Cannot find any git repository in this folder"
	else
		for PROJECT_FOLDER in $LIST; do 
			customOut reset
			if test -d "$PROJECT_FOLDER"; then
				(cd "$PROJECT_FOLDER"
					PROJECT_NAME="$(basename "$PROJECT_FOLDER")"
					BRANCH="$($GIT rev-parse --abbrev-ref HEAD)"
					STATUS="$($GIT status --porcelain)"
					if test -z "$STATUS"; then 
						BRANCH_COLOR=green
					else 
						BRANCH_COLOR=red
					fi
					test "$MGIT_QUIET" == "false" && fillLine "="
					test "$MGIT_QUIET" == "false" && customOut bold
					customOut yellow
					echo -n ">>>  "
					customOut cyan
					echo -n "$PROJECT_NAME"
					customOut $BRANCH_COLOR
					echo -n " ($BRANCH) "
					customOut reset 
					test "$MGIT_QUIET" == "false" && echo ""
					if test $# -gt 0; then 
						$GIT "$@"
					elif test "$MGIT_QUIET" == "true"; then
						echo ""
					fi
					test "$MGIT_QUIET" == "false" && fillLine "_"
				)
			fi
		done
	fi
}

customOut reset halfbright purple 
while getopts "fclq" "optchar"; do
	case "$optchar" in
		l) echo "--> mode pager"; export MGIT_MODE="pager";;
		f) echo "--> using find"; export MGIT_LIST="find";;
		c) echo "--> using conf"; export MGIT_LIST="conf";;
		q) echo "--> quiet mode"; export MGIT_QUIET="true";;
		*) exit 1;
	esac
done
shift $((OPTIND-1)) 

if [ "$MGIT_MODE" = "pager" ]; then
	main "$@" 2>&1 | $MGIT_PAGER 
else
	main "$@"
fi
