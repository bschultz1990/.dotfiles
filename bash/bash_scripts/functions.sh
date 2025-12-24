#!/bin/bash

update()
{
  echo "UPDATING SYSTEM..."
	pamac update --no-confirm
	pamac upgrade --no-confirm
  echo "CLEANING LOCAL PACKAGES..."
  pamac clean all
  pamac remove -o
  echo "CLEANING FLATPAK PACKAGES..."
  flatpak update --noninteractive
  flatpak uninstall --unused --noninteractive
}

# update_neovim() {
#   readonly nvim_filename='nvim-linux-x86_64.appimage'
#
# 	Update Neovim
# 	curl -LO https://github.com/neovim/neovim/releases/latest/download/$nvim_filename
# 	chmod u+x $nvim_filename
# 	sudo mv $nvim_filename /usr/local/bin/nvim
#   nvim --version
# }

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
  if ! [ -d ~/Documents/notes/ ]; then
    cd ~/Documents/ || return
    glab repo clone notes
  fi
  cd ~/Documents/notes || return
  git pull
  nvim +"Telescope find_files"
}

alias q='clear'
