#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../base/functions.sh"

update()
{
  echo "UPDATING SYSTEM..."
	sudo dnf update -y
	sudo dnf upgrade -y
  echo "CLEANING LOCAL PACKAGES..."
  sudo dnf clean all
  sudo dnf autoremove -y
  echo "CLEANING FLATPAK PACKAGES..."
  flatpak update --noninteractive
  flatpak uninstall --unused --noninteractive
  update_neovim 
}
