#!/bin/bash

source functions.sh

set_manager
set_appdir
sys_update

# Basic dependencies
pkginstall wget
pkginstall curl
pkginstall stow
pkginstall trash

# Git and gh-cli
function git_tools {
	brew install git
	brew install gh
	brew install jesseduffield/lazygit/lazygit
}

# Configure gh and git. Log in to GitHub
function gitconfig {
	git config --global user.name "Ben S."
	git config --global user.email "bens@noemail.com"
	gh auth login
}

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

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm


# Neovim dependencies
brew install fzf
brew install fd
brew install ripgrep
curl https://sh.rustup.rs -sSf | sh
brew install lua
brew install luarocks
brew install oracle-jdk
brew install neovim

# Ruby
if [ "$(uname -s)" = "Linux" ]; then
	sudo apt install ruby
fi

function macruby {
	if [ "$(uname -s)" = "Darwin" ]; then
		brew install chruby ruby-install
		ruby-install
		echo "Install your preferred version by typing in 'ruby-install' then the version number."
		echo "This process could take up to 15 minutes. You may skip this step and then come back to it later if you desire."
		echo "Source this script, then run 'macruby' to install Ruby."
		echo "After you're done, type, 'continue' to continue."
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
}
# Unneeded packages for now
# brew install go
# brew install composer
# brew install freerdp

echo "Installing extra applications..."
brew install lsd
brew install glow
brew install signal

# Mac Specific Apps
brew install --cask rectangle
brew install --cask iterm2
brew install --cask ao # Microsoft To Do Client

open "/Applications/Rectangle.app"

# xclip not needed on mac. Keep for Linux script.
brew install xclip

function trashconfigs {
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
}

function cloneme {
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
	}

	function stowme {
		# Stow the new stuff
		echo "Stowing from .dotfiles..."
		cd ~/.dotfiles \
			&& echo "Stowing bash..." \
			&& stow -t ~/ bash \
			&& echo "Stowing kitty..." \
			&& stow -t ~/ kitty \
			&& echo "Stowing zsh..." \
			&& stow -t ~/ zsh
		}

	# Install getnf.
	cd "$HOME/Apps" || return \
		&& git clone https://github.com/ronniedroid/getnf.git \
		&& cd getnf \
		&& ./install.sh

	echo "restarting shell..."
	exec zsh
