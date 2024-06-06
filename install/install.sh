#!/usr/bin/env bash

source functions.sh

set_manager
set_appdir
sys_update

# Basic dependencies
pkginstall antidote
pkginstall wget
pkginstall curl
pkginstall stow
pkginstall trash

echo "Installing Rust..."
curl https://sh.rustup.rs -sSf | sh

# Git and gh-cli
pkginstall git
pkginstall gh
lazygit_install

# Configure gh and git. Log in to GitHub
git config --global user.name "Ben S."
git config --global user.email "bens@noemail.com"
gh auth login

# Git Credential Manager
if [ "$(uname -s)" = "Darwin" ]; then
	brew tap microsoft/git
	brew install --cask git-credential-manager-core
fi

# Python
pkginstall python3

# Create the Apps directory if it doesn't exist already.
if [ ! -e "$HOME/Apps" ]; then
	mkdir "$HOME/Apps"
	echo "$HOME/Apps directory created!"
fi

# Install pip
cd "$HOME/Apps" || return
curl -fLo ~/Apps/get-pip.py https://bootstrap.pypa.io/get-pip.py
sudo chmod u+rwx ~/Apps/get-pip.py

# Install pynvim through pip
python3 -m pip install pynvim
python3 -m pip install --upgrade pip

# Node, Yarn, and NPM
pkginstall node
npm install -g n
sudo n install latest -y
sudo npm install -g neovim
sudo npm install -g live-server
sudo npm install -g cmdtest

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm


# Neovim dependencies
pkginstall ctags
pkginstall fzf
pkginstall fd
pkginstall rg
pkginstall lua
pkginstall luarocks
# pkginstall java
pkginstall neovim
cargo install tree-sitter-cli

# Ruby
if [ "$(uname -s)" = "Linux" ]; then
	pkginstall ruby
fi

# Unneeded packages for now
# brew install go
# brew install composer

echo "Installing extra applications..."

# Mac Specific Apps
if [ "$(uname -s)" = "Darwin" ]; then
	brew install lsd
	brew install glow
	brew install signal
	brew install --cask rectangle
	brew install --cask iterm2
	open "/Applications/Rectangle.app"
fi


# xclip not needed on mac.
pkginstall xclip

trashconfigs
cloneme
stowme
getnf

echo "restarting shell..."
exec zsh
