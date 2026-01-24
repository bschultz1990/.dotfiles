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

f() {
  nvim "$(fzf)"
}

update_neovim() {
  nvim_filename='nvim-linux-x86_64.appimage'

	curl -LO https://github.com/neovim/neovim/releases/latest/download/$nvim_filename
	chmod u+x $nvim_filename
	sudo mv $nvim_filename /usr/local/bin/nvim
  nvim --version
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
