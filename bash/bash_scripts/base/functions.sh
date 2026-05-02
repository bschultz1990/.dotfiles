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
  if ! requirements "fdfind" "fzf"; then return; fi
  cd "$(fdfind --type d --hidden | fzf)" || return
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

gsa(){
  # Git Status All
  # Source - https://stackoverflow.com/a/64707991
  # Posted by hakki
  # Retrieved 2026-04-25, License - CC BY-SA 4.0
  find . -maxdepth 1 -mindepth 1 -type d -exec sh -c '(echo {} && cd {} && git status -s && echo)' \;
}
