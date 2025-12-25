#!/bin/bash
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

notes() {
  if ! requirements "glab" "nvim"; then
    return
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
