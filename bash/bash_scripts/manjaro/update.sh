#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../base/functions.sh"

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
  sudo pacman -Rsn "$(pacman -Qdtq)"
  msg "UPDATING FLATPAK PACKAGES"
  flatpak update --noninteractive
  msg "CLEANING FLATPAK PACKAGES"
  flatpak uninstall --unused --noninteractive
}
