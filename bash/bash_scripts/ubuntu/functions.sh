#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../base/functions.sh"

update() {
  curl -sS https://starship.rs/install.sh | sh

  echo "UPDATING SYSTEM..."
  sudo apt update -y
  sudo apt upgrade -y
  echo "CLEANING LOCAL PACKAGES..."
  sudo apt autoremove

  downloadGitHubAppImage neovim/neovim 3 nvim
  downloadGitHubAppImage neovide/neovide 3 neovide
  downloadGitHubAppImage pkgforge-dev/ghostty-appimage 2 ghostty
  bash <(curl -sL https://git.io/go-installer)

  flatpak update -y

  # echo "CLEANING SNAP PACKAGES..."
  # snap refresh
  #TODO: Is there a way to clean up unused snaps?
}
