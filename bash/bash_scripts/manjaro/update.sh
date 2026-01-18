#!/bin/bash
source ./../base/functions.sh

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

  update_neovim 
}
