#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../bash/bash_scripts/base/requirements.sh"
source "$SCRIPT_DIR/../bash/bash_scripts/base/functions.sh"

echo "Installing prerequisites"

sudo apt install fzf -y
sudo apt install ripgrep -y
sudo apt install wget -y
sudo apt install xclip -y
sudo apt install golang -y

update_neovim 

# marker="$(pwd)"

cd "$HOME/"
gh repo clone .dotfiles
source "$HOME/.dotfiles/install/write_bashrc.sh"

cd ~/.config
gh repo clone nvim

# Install Font Manager
sudo apt install font-manager -y
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

# cd "$marker"
write_bashrc

cd ~/Documents/
glab auth login
glab repo clone notes
