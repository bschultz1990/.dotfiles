#!/bin/bash

sudo apt install macfanctld
sudo apt install broadcom-sta-dkms
sudo apt install git curl wget
sudo apt install gh
sudo apt install glab
gh auth login
cd ~/
gh repo clone .dotfiles
cd ~/.dotfiles/install
bash install_ubuntu.sh
