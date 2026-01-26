#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../bash/bash_scripts/base/requirements.sh"
source "$SCRIPT_DIR/../bash/bash_scripts/base/functions.sh"
source "$SCRIPT_DIR/../install/write_bashrc.sh"

echo "Installing prerequisites"

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
wget "$font_url"
echo "Installing $font_zip_name and refreshing font cache..."

font-manager -i "$font_zip_name"
fc-cache -fv


echo "MANUALLY install NodeJS and npm"
echo "Redirecting to 'https://nodesource.com/products/distributions'"
echo "For more updated instructions"
nohup xdg-open "https://nodesource.com/products/distributions" >/dev/null 2>&1 &

write_bashrc
