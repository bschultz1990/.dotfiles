#!/bin/bash

# update system
sudo apt update && sudo apt upgrade -y

# General dependencies
sudo apt install nala -y
sudo nala install git -y
sudo nala install ripgrep -y
sudo nala install xclip -y

# Install and set Kitty as default terminal:
sudo nala install kitty -y
sudo update-alternatives --config x-terminal-emulator

# Node, Yarn, and NPM
sudo nala install nodejs -y
sudo nala install cmdtest -y
sudo nala install npm -y
sudo npm install -g n
sudo n install latest -y
sudo npm install -g neovim

# Language dependencies
sudo nala install cargo -y
sudo nala install luarocks -y
sudo nala install composer -y
sudo nala install python3-pip -y
sudo nala install openjdk-11-jre-headless -y
sudo nala install ruby -y
sudo nala install openjdk-17-jdk-headless -y
sudo nala install golang-go -y
sudo nala install python3 -y
python3 -m pip install --user --upgrade pynvim
sudo nala install juila -y

# NEOVIM
# FiraCode Nerd Font
echo "Installing FiraCode Nerd Font"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/}"Downloads/firacode.zip --create-dirs \
			https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip'
mkdir "${XDG_DATA_HOME:-$HOME}"/.fonts
unzip firacode.zip -d firacode
cp firacode/'Fira Code Light Nerd Font Complete.ttf' ~/.fonts
rm -r "${XDG_DATA_HOME:-$HOME}"/Downloads/firacode
rm "${XDG_DATA_HOME:-$HOME}"/Downloads/firacode.zip

# Vim-Plug
echo "Installing Vim-Plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install Neovim notice
echo "Opening install link to Neovim."
xdg-open "https://github.com/neovim/neovim/releases/latest"

# Install Lua notice
echo "Opening install link to Lua"
xdg-open "https://www.lua.org/versions.html"
