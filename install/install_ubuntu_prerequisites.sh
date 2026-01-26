#!/bin/bash

sudo apt install macfanctld -y
sudo apt install broadcom-sta-dkms -y
sudo apt install git -y
sudo apt install curl -y
sudo apt install wget -y
sudo apt install gh -y
sudo apt install glab -y
gh auth login
cd ~/
gh repo clone .dotfiles
cd ~/.dotfiles/install
pwd
echo "Copy this path and cd into it to run the Ubuntu install script."
