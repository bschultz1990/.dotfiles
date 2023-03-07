#!/bin/bash

# Set cross-system variables


# update Linux System
if [ "$(uname -s)" = "Linux" ]; then
	echo "Updating Linux"
	sudo apt update && sudo apt upgrade -y
fi

if [ "$(uname -s)" = "Darwin" ]; then
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
	brew install --cask macs-fan-control
	open "/Applications/Macs Fan Control"

	# Antidote zsh plugin manager
	brew install antidote
	
	# Install git-credential-manager
	brew install git-credential-manager-core
	# Upgrading? Use this:
	# brew upgrade git-credential-manager-core
	# Uninstall:
	# brew uninstall --cask git-credential-manager-core
fi

# Create the Apps directory if it doesn't exist already.
if [ ! -e "~$HOME/Apps" ]; then
	mkdir "~$HOME/Apps"
	echo "$HOME/Apps directory created!"
fi

# Basic dependencies
brew install wget
brew install curl
brew install stow
brew install trash-cli

# Git and gh-cli
brew install git
brew install gh
brew install jesseduffield/lazygit/lazygit

# Configure gh and git. Log in to GitHub
git config --global user.name "Ben S."
git config --global user.email "bens@noemail.com"
gh auth login

# Python
brew install python@3.11 \
	&& cd "$HOME/Apps" || return \
	&& curl -fLo ~/Apps/get-pip.py \
	&& https://bootstrap.pypa.io/get-pip.py \
	&& sudo chmod u+rwx ~/Apps/get-pip.py

# Install pynvim through pip
python3 -m pip install pynvim
python3 -m pip install --upgrade pip

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

# Neovim dependencies
brew install fzf
brew install fd
brew install ripgrep
brew install rust
brew install lua
brew install luarocks
brew install oracle-jdk
brew install neovim

# Ruby
if [ "$(uname -s)" = "Linux" ]; then
	sudo apt install ruby
fi


if [ "$(uname -s)" = "Darwin" ]; then
	brew install chruby ruby-install
	ruby-install
	echo "Install your preferred version by typing in 'ruby-install' then the version number."
	echo "This process could take up to 15 minutes. You may skip this step and then come back to it later if you desire."
	echo "Enter your commands, then type 'continue' to continue installing other packages..."
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
# Unneeded packages for now
# brew install go
# brew install composer
# brew install freerdp

echo "Installing extra applications..."
brew install lsd
brew install glow
# Mac Specific Apps
brew install bitwarden
brew install signal
brew install --cask rectangle
brew install --cask iterm2
brew install --cask ao # Microsoft To Do Client

open "/Applications/Rectangle.app"

# xclip not needed on mac. Keep for Linux script.
# brew install xclip
# Python

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm

function trashconfigs {
	echo "hi!"
}


# Trash existing configs
echo "Trashing existing configs. Recover using 'trash-restore'"
cd ~/ || return
trash ~/.bashrc
trash ~/.zshrc
trash ~/.zsh_plugins.txt
trash ~/.zsh_plugins.zsh
cd ~/.config || return
trash kitty
trash nvim

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
	&& stow -t ~/ bash \
	&& echo "Stowing kitty..." \
	&& stow -t ~/ kitty \
	&& echo "Stowing zsh..." \
	&& stow -t ~/ zsh

# Install getnf.
cd "$HOME/Apps" || return \
	&& git clone https://github.com/ronniedroid/getnf.git \
	&& cd getnf \
	&& ./install.sh

echo "restarting shell..."
exec zsh
