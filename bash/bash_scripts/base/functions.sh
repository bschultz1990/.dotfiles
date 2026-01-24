#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/requirements.sh"

c() {
  clear
  cd "$1" || cd . || return
  ls -a1
}

b() {
  clear
  cd ..
  ls -a1
}

f() { 
  if ! requirements "fzf"; then return; fi
  open "$(fzf)"; 
}

n() {
  if ! requirements "nvim" "fzf"; then return; fi
  nvim "$(fzf)"
}

d() { 
  if ! requirements "fdfind"; then return; fi
  cd "$(fdfind -type d | fzf)" || return
}

update_neovim() {
  nvim_filename='nvim-linux-x86_64.appimage'

  curl -LO https://github.com/neovim/neovim/releases/latest/download/$nvim_filename
  chmod u+x $nvim_filename
  sudo mv $nvim_filename /usr/local/bin/nvim
  nvim --version
}

notes() {
  if ! requirements "glab" "nvim"; then return
  else
    if ! [ -d ~/Documents/notes/ ]; then
      cd ~/Documents/ || return
      glab repo clone notes
    fi
    cd ~/Documents/notes || return
    git pull
    nvim +"Telescope find_files"
  fi
}

alias q='clear'
