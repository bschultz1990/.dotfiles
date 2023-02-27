#!/bin/bash

# Git and gh-cli
nix-env -iA \
	nixpkgs.git \
	nixpkgs.gh
# Configure gh and git. Log in to GitHub
git config --global user.name "Ben S."
git config --global user.email "bens@noemail.com"
git config --global submodule.recurse true
gh auth login

# Install git-credential-manager
brew tap microsoft/git
brew install --cask git-credential-manager-core

# Upgrading? Use this:
# brew upgrade git-credential-manager-core

# Uninstall:
# brew uninstall --cask git-credential-manager-core

# General dependencies
nix-env -iA \
	nixpkgs.stow \
	nixpkgs.trash-cli \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.xclip \
	nixpkgs.freerdp \
	nixpkgs.cargo \
	nixpkgs.lua \
	nixpkgs.luajitPackages.luarocks \
	nixpkgs.php82Packages.composer \
	nixpkgs.jre8 \
	nixpkgs.ruby \
	nixpkgs.go \
	nixpkgs.lsd \
	nixpkgs.glow \
	nixpkgs.neovim
	
# Python, pip, and pynvim
# Python
nix-env -iA nixpkgs.python311 \
	&& curl -fLo ~/Downloads/get-pip.py \
	&& https://bootstrap.pypa.io/get-pip.py \
	&& sudo chmod u+rwx ~/Downloads/get-pip.py

# Install pynvim through pip
cd "$HOME/Downloads"|| exit
python3 -m pip install pynvim

# Install and set Kitty as default terminal:
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
if [ "$(uname -s)" = "Linux" ]; then
	sudo update-alternatives --config x-terminal-emulator
fi

# Node, Yarn, and NPM
nix-env -iA nixpkgs.nodejs \
	&& sudo n install latest -y \
	&& sudo npm install -g neovim \
	&& sudo npm install -g live-server \
	&& sudo npm install -g cmdtest \
	&& npm fund

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm

# Install Nix-Locate
nix-env -iA nixos.nix-index

# Trash existing configs
echo "Trashing existing configs. Recover using 'trash-restore'" \
	&& cd ~/ \
	&& trash ~/.bashrc \
	&& trash ~/.zshrc \
	&& trash ~/.gitconfig \
	&& cd ~/.config \
	&& trash kitty \
	&& trash nvim

# Clone .dotfiles
echo "Cloning /.dotfiles" \
	&& cd ~/ \
	&& git clone https://github.com/bschultz1990/.dotfiles

# Clone nvim repo
echo "Cloning nvim config." \
	&& cd ~/.config \
	&& git clone --depth 1 https://github.com/bschultz1990/nvim

# Clone notes
echo "Cloning notes" \
	&& cd ~/Documents/ \
	&& git clone https://github.com/bschultz1990/notes

# Stow the new stuff
cd ~/.dotfiles \
	&& echo "Stowing bash..." \
	&& stow bash \
	&& echo "Stowing kitty..." \
	&& stow kitty \
	&& echo "Stowing zsh..." \
	&& stow zsh

# Install getnf.
