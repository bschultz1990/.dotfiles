#!/bin/bash

paths()
{
  fzf < <(cat ~/.dotfiles/bash/bash_scripts/paths.sh)
}

paths_edit()
{
  nvim ~/.dotfiles/bash/bash_scripts/paths.sh
}

# load neovim sessions
sessions()
{
  c ~/Documents/vim_sessions/
  nvim -S "$(fzf)"
}

update()
{
	sudo apt update
	sudo apt upgrade -y
  sudo apt autoremove
  flatpak update -y

	# Update NeoVim
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim
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
    cd ~/Documents/
    gh repo clone notes
  fi
  cd ~/Documents/notes
  git pull
  nvim +"Telescope find_files"
}

alias q='clear'
