#!/bin/bash

msg()
{
  echo -e "\n"
  echo -e "========================="
  echo -e "$1..."
  echo -e "========================="
  echo -e "\n"
}

update()
{
  msg "UPDATING SYSTEM"
  sudo pacman -Syu
  msg "CLEANING LOCAL PACKAGES"
  sudo pacman -Rsn $(pacman -Qdtq)
  msg "CLEANING FLATPAK PACKAGES"
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
