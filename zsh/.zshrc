# Plugins
source ~/.zsh_scripts/git-auto-fetch/git-auto-fetch.plugin.zsh

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

# Easily install Nix packages
function nix-install {
	nix-env -iA nixpkgs."$1"
}

function nix-remove {
	nix-env --uninstall nixpkgs."$1"
}

function nix-search {
	open "https://search.nixos.org/packages?channel=22.11&from=0&size=50&sort=relevance&type=packages&query=""$1"
}

# Display a man page in Neovim
function mann {
	if [ -z "$1"]; then
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
	if [ -z "$1"]; then
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
