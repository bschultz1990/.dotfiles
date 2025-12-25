#!/usr/bin/bash

# Enter your name and email for git config later
echo "Enter your name:"; read user_name
echo "Enter your email:"; read user_email
echo "Name: $user_name"; echo "Email: $user_email"


sudo dnf install mbpfan
sudo systemctl enable mbpfan
sudo systemctl start mbpfan


echo "Uninstalling LibreOffice and Updating System..."
sudo dnf remove *libreoffice* -y
echo "Performing a full system upgrade..."
sleep 1
kill $(pgrep firefox)
sudo dnf update -y
sudo dnf upgrade -y


echo "Configuring git, gh, and glab..."
sudo dnf install glab gh


echo "Installing .dotfiles and configuring ~/.bashrc..."
cd ~/ || exit
gh repo clone .dotfiles
echo "


# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/fedora/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/fedora/*; do
        . $file
    done
fi

if [ -d ~/.dotfiles/bash/bash_scripts/base/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/base/*; do
        . $file
    done
fi" >> ~/.bashrc

echo "Installing Neovim and friends..."
sleep 1
echo "nvim:";sudo dnf install nvim -y
echo "fzf";sudo dnf install fzf -y
echo "xclip";sudo dnf install xclip -y
echo "npm";sudo dnf install npm -y
echo "ripgrep";sudo dnf install ripgrep -y
echo "tree-sitter";sudo dnf install tree-sitter tree-sitter-cli -y


echo "Installing other apps..."
sleep 1
sudo dnf install fastfetch getnf gnome-font-viewer -y


echo "Downloading notes..."
gh repo clone notes ~/Documents/notes


echo "Installing starship prompt..."
sudo dnf install starship -y
echo 'eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml' >> ~/.bashrc


echo "Installing Typst and friends..."
sudo dnf install typst -y
