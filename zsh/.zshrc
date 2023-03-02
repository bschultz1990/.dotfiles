# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#!/bin/bash

# Plugins
source "/usr/local/Cellar/antidote/1.8.1/share/antidote/antidote.zsh"
antidote load

# Custom Aliases
alias gpull='git pull'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m "Added files via CMD"'
alias gp='git push origin HEAD' # Push local branch to matching remote branch.
alias gsw='git switch'
alias fnkeys='echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode'
alias eses='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /microphone:sys:alsa /sound:sys:alsa /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
alias eses-nosound='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
alias eses-all='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'


alias test='xfreerdp /u:"bens" /v:192.168.10.22 /g:remote.pellethead.com -themes /usb:id:dev:0b0e:245e /microphone:sys:alsa /sound:sys:alsa /monitors:2,1 /multimon:force +auto-reconnect /auto-reconnect-max-retries:10 +bitmap-cache /compression-level:3 /network:modem'
# FreeRDP CLI Documentation. More options! :)
# https://github.com/FreeRDP/FreeRDP/wiki/CommandLineInterface

alias update='sudo nala update && sudo nala upgrade -y'

function ls {
    cmd="ls"
    args=(-1A)
    # Is lsd installed?
    if type "lsd" &>/dev/null; then
        cmd="lsd"
        args=(-1A --tree --depth 1)
    fi
    # Use default arguments if none are provided
    if [ ${#} -eq 0 ]; then
        set -- "${args[@]}"
    fi
    "${cmd}" "${args[@]}" "${@}"
}

# Find anything anywhere and open in terminal editor.
function f {
	# local find_command=
	find . "$HOME" | fzf --preview-window right | xargs "$EDITOR"
}

# Change to a directory and list files.
function c {
	clear
	cd "$1" || return
	lsd
}

alias cd='c'

# Make a directory and change to it.
function take {
	mkdir -p "$1"
	cd "$1" || return
}

# Touch alias
function t {
	# Loop over all file arguments passed to the function:
	for file in "$@"; do
		touch "$file"
	done

	# List all the files in the directory:
	clear
	lsd
}

# Reload shell environment!

# Display a man page and edit it in the default editor.
function mann {
	if [ -z "$1" ]; then
		# If not, print error message
		echo "Error: no command provided."
		return 1
	fi
	# Copy the man page text and open it in Nvim
	man "$1" | col -bx > /tmp/manpage.txt
	$EDITOR /tmp/manpage.txt
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
	$EDITOR /tmp/output.txt
}

# Safer file deletion. Requires trash-cli
if type trash &> /dev/null; then
	alias rm='trash'
	alias rmdir='trash'
fi

notepath="$HOME/Documents/notes/"

function note {
	{ echo "Date: $(date)"; echo "$@"; echo ""; } >> "$notepath"/notes.txt
	}

	function notes {
		$EDITOR "$notepath"/notes.txt
	}

	function webnotes {
		cd "$HOME"/Documents/webdevelopmentbootcamp/notes/ || return
		nvim notes.md +MarkdownPreview
	}

	function webprojects {
		cd "$HOME"/Documents/webdevelopmentbootcamp/Projects/ || return
		nvim .
	}

	function kittyconfig {
		cd "$HOME"/.dotfiles/kitty/.config/kitty || return
		nvim kitty.conf
	}

# Create directories when moving files
function mvv {
	mkdir -p "$2"; mv "$1" "$2"
}

function mdb {
	mongosh mongodb+srv://wdbc.rrnu9ou.mongodb.net/"$1" --apiVersion 1 --username bschultz1990
}

# Custom PATH Additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Apps:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
