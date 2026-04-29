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
  downloadGitHubAppImage TibixDev/winboat 2 winboat

  ## Lazygit start------
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
  LAZYGIT_ARCH=$(uname -m | sed -e 's/aarch64/arm64/')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_${LAZYGIT_ARCH}.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit -D -t /usr/local/bin/
  rm lazygit.tar.gz
  rm lazygit
  ## Lazygit end--------

  flatpak update -y

  # echo "CLEANING SNAP PACKAGES..."
  # snap refresh
  #TODO: Is there a way to clean up unused snaps?
}
