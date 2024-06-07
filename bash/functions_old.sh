
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
