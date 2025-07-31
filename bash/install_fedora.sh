#!/bin/bash

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf remove *libreoffice* -y

echo "Installing mbpfan"
sudo dnf install mbpfan -y

sudo echo"

min_fan1_speed = 4000
min_fan2_speed = 4000
max_fan1_speed = 6200
max_fan2_speed = 6200
" >> /etc/mbpfan.conf

sudo systemctl start mbpfan.service
sudo systemctl enable mbpfan
sudo systemctl enable systemd-resolved

echo "Installing wireless drivers. Reboot to complete the install."
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install broadcom-wl -y

echo "Installing extras..."
sudo dnf install neovim fzf glab konsole gh glab fastfetch -y

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


echo "Getting notes..."
cd ~/Documents/
glab auth login
ghab repo clone notes
cd ~/

echo "All done! :) Restarting soon..."
