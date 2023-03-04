# Save this for later configuration.
# zsh config dir:
# export ZDOTDIR=$HOME/.config/zsh

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


function colors {
  # ChatGPT colorscheme...
  # Define variables for each color
  red='\033[0;31m'
  green='\033[0;32m'
  yellow='\033[0;33m'
  blue='\033[0;34m'
  purple='\033[0;35m'
  cyan='\033[0;36m'
  white='\033[0;37m'

# Define variables for bold versions of each color
bold_red='\033[1;31m'
bold_green='\033[1;32m'
bold_yellow='\033[1;33m'
bold_blue='\033[1;34m'
bold_purple='\033[1;35m'
bold_cyan='\033[1;36m'
bold_white='\033[1;37m'

# Define variables for background colors
bg_red='\033[41m'
bg_green='\033[42m'
bg_yellow='\033[43m'
bg_blue='\033[44m'
bg_purple='\033[45m'
bg_cyan='\033[46m'
bg_white='\033[47m'

# Reset all color changes
reset='\033[0m'

# Print a message using each color and background color
echo -e "${red}Red text${reset}"
echo -e "${green}Green text${reset}"
echo -e "${yellow}Yellow text${reset}"
echo -e "${blue}Blue text${reset}"
echo -e "${purple}Purple text${reset}"
echo -e "${cyan}Cyan text${reset}"
echo -e "${white}White text${reset}"
echo -e "${bold_red}Bold red text${reset}"
echo -e "${bold_green}Bold green text${reset}"
echo -e "${bold_yellow}Bold yellow text${reset}"
echo -e "${bold_blue}Bold blue text${reset}"
echo -e "${bold_purple}Bold purple text${reset}"
echo -e "${bold_cyan}Bold cyan text${reset}"
echo -e "${bold_white}Bold white text${reset}"
echo -e "${bg_red}Red background${reset}"
echo -e "${bg_green}Green background${reset}"
echo -e "${bg_yellow}Yellow background${reset}"
echo -e "${bg_blue}Blue background${reset}"
echo -e "${bg_purple}Purple background${reset}"
echo -e "${bg_cyan}Cyan background${reset}"
echo -e "${bg_white}White background${reset}"
}

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

# Change to LazyGit directory on LazyGit exit
lg()
{
  export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir
  lazygit "$@"
  if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
    cd "$(cat $LAZYGIT_NEW_DIR_FILE)" || return
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  fi
}

# Change to a directory and list files.
function c {
  clear
  cd "$1" || return
  lsd
}

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
    cd "$notepath" || return
    echo "Pulling changes and opening..."
    git pull || return
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

