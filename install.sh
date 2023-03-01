#!/bin/bash

# update Linux System
if [ "$(uname -s)" = "Linux" ]; then
	echo "Updating Linux"
	sudo apt update && sudo apt upgrade -y
fi

if [ "$(uname -s)" = "Darwin" ]; then
	# Create the Apps directory if it doesn't exist already.
	if [ ! -e ~/Apps ]; then
		mkdir ~/Apps
		echo "$HOME/Apps directory created!"
	fi

	echo "Installing Homebrew Package Manager..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	# Pause the script and allow the user to input commands 
	echo "Enter your commands or type 'continue' to resume:"
	while true; do
		read -r -p "> " input
		if [ "$input" == "continue" ]; then
			break
		else
			# Execute the user's command
			eval "$input"
		fi
	done
fi

brew install --cask macs-fan-control

# Git and gh-cli
brew install git
brew install gh

# Configure gh and git. Log in to GitHub
git config --global user.name "Ben S."
git config --global user.email "bens@noemail.com"
gh auth login

# Install git-credential-manager
brew tap microsoft/git
brew install --cask git-credential-manager-core

# Upgrading? Use this:
# brew upgrade git-credential-manager-core

# Uninstall:
# brew uninstall --cask git-credential-manager-core

# General dependencies
brew install stow
brew install trash-cli
brew install fzf
brew install fd
brew install wget
brew install ripgrep
brew install xclip
brew install freerdp
brew install rust
brew install lua
brew install luarocks
brew install composer
brew install ruby
brew install --cask oracle-jdk
brew install --cask rectangle
brew install chruby
brew install go
brew install lsd
brew install glow
brew install neovim
brew install --cask iterm2
brew install typewritten

# Python, pip, and pynvim
# Python
brew install python@3.11 \
	&& curl -fLo ~/Downloads/get-pip.py \
	&& https://bootstrap.pypa.io/get-pip.py \
	&& sudo chmod u+rwx ~/Downloads/get-pip.py

# Install pynvim through pip
cd "$HOME/Downloads" || return
python3 -m pip install pynvim

# # Install and set Kitty as default terminal:
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# if [ "$(uname -s)" = "Linux" ]; then
# 	sudo update-alternatives --config x-terminal-emulator
# fi

# Node, Yarn, and NPM
brew install node \
	&& npm install -g n \
	&& sudo n install latest -y \
	&& sudo npm install -g neovim \
	&& sudo npm install -g live-server \
	&& sudo npm install -g cmdtest \
	&& npm fund

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm

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
cd "$HOME/Apps" || return \
	&& git clone https://github.com/ronniedroid/getnf.git \
	&& cd getnf \
	&& ./install.sh
