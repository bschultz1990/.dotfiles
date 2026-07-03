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
  if ! requirements "fzf"; then
    return
  fi

  if which fd >/dev/null 2>&1; then
    cd "$(fd --type d --hidden | fzf)" || return
    return 0
  fi

  if which fdfind >/dev/null 2>&1; then
    cd "$(fdfind --type d --hidden | fzf)" || return
    return 0
  fi

  echo "Please install 'fd' or 'fdfind' to continue" >&2
  return 1
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


cwd(){
  if ! requirements "xclip"; then return
  else
    pwd | xclip -selection clipboard
  fi
}


fzfrmdir(){
  if ! requirements "fzf" "fdfind"; then return;
  else
    mapfile -t directories < <( fdfind --type d --hidden | fzf -m )

    for item in "${directories[@]}"; do
      gio trash -- "$item"
    done
  fi
}


fzfrm(){
  if ! requirements "fzf"; then return;
  else
    command -v fzf >/dev/null || return
    mapfile -t items < <(fzf -m)

    for item in "${items[@]}"; do
      gio trash -- "$item"
    done
  fi
}
