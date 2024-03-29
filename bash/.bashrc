## ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

## Custom Functions

# Git clone
function clone {

	if [ $# -eq 0 ]; then
		echo "Please enter repo name or full url:";
		read repo;
		clone $repo;
	elif [[ $1 == --help ]] || [[ $1 == --h ]] || [[ $1 == --? ]]; then
		echo "This will clone a git repo.";
		echo "";
		echo "Option 1: You can just provide the name, eg:";
		echo "$ clone membership";
		echo "This will do: git clone https://github.com/phillip-kruger/membership.git";
		echo "";
		echo "Option 2: Provide the full URL";
		echo "$ clone https://github.com/smallrye/smallrye-rest-client.git";
		echo "This will do: git clone https://github.com/smallrye/smallrye-rest-client.git";
	else    
		if [[ $1 == https://* ]] || [[ $1 == git://* ]] || [[ $1 == ssh://* ]] ; then
			URL=$1;
		else
			URL='http://www.github.com/bschultz1990/'$1'.git';
		fi    

		echo git clone --filter=blob:none "$URL";
		git clone --filter=blob:none "$URL";
	fi
}
export -f clone

# Enable Git Status
source /etc/bash_completion.d/git-prompt
export GIT_PS1_SHOWDIRTYSTATE=1
export PS1='\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 "(%s)")\$ '

# Custom Aliases
alias gpull='git pull'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m "Added files via CMD"'
alias gp='git push' # Push local branch to matching remote branch.
alias gsw='git switch'
alias fnkeys='echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode'
alias eses='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /microphone:sys:alsa /sound:sys:alsa /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
alias eses-nosound='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
alias eses-all='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'


alias test='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /usb:id:dev:0b0e:245e /microphone:sys:alsa /sound:sys:alsa /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
# FreeRDP CLI Documentation. More options! :)
# https://github.com/FreeRDP/FreeRDP/wiki/CommandLineInterface

alias update='sudo nala update && sudo nala upgrade -y'

# Ls alias. More colors!
alias ls='lsd'

# Find anything anywhere and open in Neovim.
function f {
	fdfind . '/home/bens/' --type f --hidden --exclude .git | fzf --preview-window right | xargs nvim
}

# Change to a directory and list files.
function c {
	clear
	cd $1
	lsd -lah
}

alias cd='c'

# Make a directory and change to it.
function take {
	mkdir -p $1
	cd $1
}

# Touch alias
function t {
	# Loop over all file arguments passed to the function:
	for file in "$@"; do
		touch "$file"
	done

	# List all the files in the directory:
	clear
	lsd -lah
}


# Display a man page in Neovim
function mann {
	if [ -z "$1" ]; then
		# If not, print error message
		echo "Error: no command provided."
		return 1
	fi
	# Copy the man page text and open it in Nvim
	man "$1" | col -bx > /tmp/manpage.txt
	nvim /tmp/manpage.txt
}

# Copy the output of a command and open it in nvim.
function output {
	if [ -z "$1" ]; then
		# If not, print error message
		echo "Error: no command provided."
		return 1
	fi
	# Copy the command outpt and open it in Nvim
	"$1" | col -bx > /tmp/output.txt
	nvim /tmp/output.txt
}

# Safer file deletion. Requires trash-cli
alias rm='trash'
alias rmdir='trash'


function note {
	echo "Date: $(date)" >> $HOME/.dotfiles/notes/notes/notes.txt
	echo "$@" >> $HOME/.dotfiles/notes/notes/notes.txt
	echo "" >> $HOME/.dotfiles/notes/notes/notes.txt
}

function notes {
	nvim $HOME/.dotfiles/notes/notes/notes.txt
}

function webnotes {
	cd $HOME/Documents/webdevelopmentbootcamp/notes/
	nvim notes.md +MarkdownPreview
}

function webprojects {
	cd $HOME/Documents/webdevelopmentbootcamp/Projects/
	nvim .
}

function bp {
	node $HOME/Documents/webdevelopmentbootcamp/Projects/bp/bp.js $1
}

function kittyconfig {
	cd ~/.dotfiles/kitty/.config/kitty
	nvim kitty.conf
}

# Create directories when moving files
function mvv {
	mkdir -p $2; mv $1 $2
}

function mdb {
	mongosh mongodb+srv://wdbc.rrnu9ou.mongodb.net/$1 --apiVersion 1 --username bschultz1990
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
	local syntax="${1:-python}"
	shift
	nvim -c \
		"let g:startify_disable_at_vimenter = 1 |\
		set bt=nofile ls=0 noru nonu nornu |\
		hi ColorColumn ctermbg=NONE |\
		hi VertSplit ctermbg=NONE |\
		hi NonText ctermfg=0 |\
		Codi $syntax" "$@"
	}

# Custom PATH Additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Apps:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim
