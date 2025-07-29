#!/bin/bash

sudo dnf update -y
dnf upgrade -y
dnf install neovim fzf glab fastfetch

echo "Installing .dotfiles and updating ~/.bashrc..."
gh auth login
cd ~/
gh repo clone .dotfiles
echo "

# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi" >> ~/.bashrc

echo "Installing wireless drivers. Reboot to complete the install."

sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install broadcom-wl

echo "Getting notes..."
cd ~/Documents/
glab auth login
ghab repo clone notes
cd ~/
