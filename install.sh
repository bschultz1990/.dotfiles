#!/bin/bash

# update system
sudo apt update && sudo apt upgrade -y

# install packages
sudo apt install nala -y

# neovim packages and plugin dependencies:
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
apt install nodejs -y


# Install Neovim notice
echo "Install Neovim from this link:"
echo "https://github.com/neovim/neovim/releases/latest"


