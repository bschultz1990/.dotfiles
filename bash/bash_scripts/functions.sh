#!/bin/bash

paths()
{
  fzf < <(cat ~/.dotfiles/bash/bash_scripts/paths.sh)
}

paths_edit()
{
  nvim ~/.dotfiles/bash/bash_scripts/paths.sh
}

update()
{
	sudo apt update
	sudo apt upgrade -y
  sudo apt autoremove
  flatpak update -y

  readonly nvim_filename='nvim-linux-x86_64.appimage'

	# Update NeoVim
	curl -LO https://github.com/neovim/neovim/releases/latest/download/$nvim_filename
	chmod u+x $nvim_filename
	sudo mv $nvim_filename /usr/local/bin/nvim
  nvim --version
}

c() {
  clear
  cd "$1" || return
  ls -a1
}

b() {
  clear
	cd ..
	ls -a1
}

notes() {
  if ! [ -d ~/Documents/notes/ ]; then
    cd ~/Documents/ || return
    glab repo clone notes
  fi
  cd ~/Documents/notes || return
  git pull
  nvim +"Telescope find_files"
}

alias q='clear'
