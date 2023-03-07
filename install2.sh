#!/bin/bash

# Install Nix-Locate
nix-env -iA nixos.nix-index

# Git and gh-cli
nix-env -iA \
	nixpkgs.git \
	nixpkgs.gh
	# Configure gh and git. Log in to GitHub
	git config --global user.name "Ben S."
	git config --global user.email "bens@noemail.com"
	gh auth login

# Install Linux-specific packages.
if [ "$(uname -s)" = "Linux" ]; then
	nix-env -iA \
		nixpkgs.xclip
fi

# General dependencies
nix-env -iA \
	nixpkgs.stow \
	nixpkgs.trash-cli \
	nixpkgs.fzf \
	nixpkgs.ripgrep \
	nixpkgs.cargo \
	nixpkgs.lua \
	nixpkgs.luajitPackages.luarocks \
	nixpkgs.jre8 \
	nixpkgs.lsd \
	nixpkgs.glow \
	nixpkgs.neovim

# Special Ruby install for Macs. Normal for Linux.
if [ "$(uname -s)" = "Darwin" ]; then
	brew install chruby ruby-install
	ruby-install
	echo "Install your preferred version by typing in 'ruby-install' then the version number."
	echo "This process could take up to 15 minutes. You may skip this step by typing 'continue'."
	while true; do
		read -r -p "> " input
		if [ "$input" == "continue" ]; then
			break
		else
			# Execute the user's command
			eval "$input"
		fi
	done
elif [ "$(uname -s)" = "Linux" ]; then
	nix-env -iA nixpkgs.ruby
fi

	# nixpkgs.php82Packages.composer
	# nixpkgs.go
	# nixpkgs.freerdp \

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
# curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
# if [ "$(uname -s)" = "Linux" ]; then
# 	sudo update-alternatives --config x-terminal-emulator
# fi

# Node, Yarn, and NPM
nix-env -iA nixpkgs.nodejs \
	&& sudo n install latest -y \
	&& sudo npm install -g neovim \
	&& sudo npm install -g live-server \
	&& sudo npm install -g cmdtest \
	&& npm fund

# Set ownership of ~/.npm
sudo chown -R 501:20 ~/.npm

# Other Nice Applications
nix-env -iA \
	&& nixpkgs.signal-desktop \
	&& iterm2

# Trash existing configs
echo "Trashing existing configs. Recover using 'trash-restore'"
cd ~/ || return
trash ~/.bashrc
trash ~/.zshrc
trash ~/.zsh_plugins.txt
trash ~/.zsh_plugins.zsh
trash ~/.gitconfig
cd ~/.config || return
trash kitty
trash nvim

# Trash existing repos and start fresh
echo "Trashing existing repos if any..." \
	&& cd ~/ || return && trash .dotfiles \
	&& cd ~/Documents || return && trash notes \

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
