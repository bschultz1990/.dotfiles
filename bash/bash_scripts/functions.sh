#!/bin/bash

sessions()
{
  c ~/Documents/vim_sessions/
  nvim -S $(fzf)
}

update()
{
	sudo apt update
	sudo apt upgrade -y
  sudo apt autoremove

	# Update NeoVim
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
	chmod u+x nvim.appimage
	sudo mv nvim.appimage /usr/local/bin/nvim
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

alias q='clear'
