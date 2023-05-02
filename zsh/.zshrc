#!/usr/bin/env bash

# Save this for later configuration.
# zsh config dir:
# export ZDOTDIR=$HOME/.config/zsh
system="$(uname -s)"
antidote_path="$HOME/.antidote" 
[ "$system" = "Linux" ] && alias update='sudo nala update && sudo nala upgrade -y'
[ "$system" = "Darwin" ] && alias update='brew update && brew upgrade && brew doctor'

# Plugins
# Install Antidote if it doesn't exist.
[ ! -d "$antidote_path" ] \
  && echo "Antidote not installed. Installing..." \
  && git clone --depth=1 https://github.com/mattmc3/antidote.git "$antidote_path"

source "$antidote_path""/antidote.zsh"
antidote load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Custom Aliases
alias gpull='git pull'
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m "Added files via CMD"'
alias gp='git push origin HEAD' # Push local branch to matching remote branch.
alias fnkeys='echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode'
# FreeRDP CLI Documentation. More options! :)
# https://github.com/FreeRDP/FreeRDP/wiki/CommandLineInterface

# Use fzf to open a directory.
function f {
  cd "$(find . -type d | fzf)" || return
}

function noderun {
  node -i -e "$(< "$1")"
}

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

function reload {
  exec zsh
}

# Change to a directory and list files.
function c {
  clear
  cd "$1" || return
  ls
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
  ls
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

  function webprojects {
    cd "$HOME"/Documents/webdevelopmentbootcamp/Projects/ || return
    nvim .
  }

# Create directories when moving files
function mvv {
  mkdir -p "$2"; mv "$1" "$2"
}

function mdb {
  mongosh mongodb+srv://wdbc.rrnu9ou.mongodb.net/"$1" --apiVersion 1 --username bschultz1990
}

function pkgsearch {
  open "https://archlinux.org/packages/?sort=&q=""$1""&maintainer=&flagged="
  open "https://search.nixos.org/packages?channel=22.11&show=mongosh&from=0&size=50&sort=relevance&type=packages&query=""$1"
  open "https://formulae.brew.sh/formula/""$1""#default"
  open "https://formulae.brew.sh/formula/cask/""$1""#default"
  open "https://packages.ubuntu.com/search?suite=default&section=all&arch=any&keywords=""$1""&searchon=names"
}

# Custom PATH Additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Apps:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export EDITOR=nvim

if [ "$system" = "Darwin" ]; then
  # External Sources
  source "/usr/local/opt/chruby/share/chruby/chruby.sh"
  # Enable auto-switching of Rubies via .ruby-version files
  source "/usr/local/opt/chruby/share/chruby/auto.sh" 
  chruby ruby-3.2.1
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
