#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../bash/bash_scripts/base/requirements.sh"
source "$SCRIPT_DIR/../bash/bash_scripts/base/functions.sh"

echo "Installing prerequisites"

sudo apt install macfanctld
sudo apt install git curl wget
sudo apt install glab gh
# gh auth login
# glab auth login
sudo apt install fzf
sudo apt install ripgrep
sudo apt install wget
sudo apt install xclip

update_neovim 


# Install Font Manager
sudo apt install font-manager
cd "$HOME/Downloads" || return
font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
font_zip_name="${font_url##*/}"
wget "$font_zip_name"
echo "Installing $font_zip_name and refreshing font cache..."

font-manager -i 
fc-cache -fv


echo "MANUALLY install NodeJS and npm"
echo "Redirecting to 'https://nodesource.com/products/distributions'"
echo "For more updated instructions"
nohup xdg-open "https://nodesource.com/products/distributions" >/dev/null 2>&1 &



write_bashrc () {
  if ! requirements "rg"; then return; fi

  script_directory=$(realpath "$(dirname "$0")")
  echo "Working in: $script_directory"

  if [ ! -f ~/.bashrc ]; then
    echo "Creating ~/.bashrc file"
    touch ~/.bashrc
    chmod u+x ~/.bashrc
  fi

  if rg '# Bash Scripts' ~/.bashrc -q; then
    return
  fi

  echo "Writing to .bashrc"
  cat "$script_directory/ubuntu_bashrc_snippet.sh" >> ~/.bashrc
}

write_bashrc

