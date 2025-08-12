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
cd ~/
gh repo clone .dotfiles
echo '

# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi' >> ~/.bashrc

echo "Installing Neovim and friends..."
sleep 1
echo "nvim:";sudo dnf install nvim -y
echo "fzf";sudo dnf install fzf -y
echo "xclip";sudo dnf install xclip -y
echo "npm";sudo dnf install npm -y
echo "ripgrep";sudo dnf install ripgrep -y
echo "tree-sitter";sudo dnf install tree-sitter tree-sitter-cli -y


echo "Configuring Neovim..."
echo ""
sleep 1
git clone https://github.com/NvChad/starter ~/.config/nvim
sudo rm -r ~/.config/nvim/.git
gh repo clone nvim ~/.config/nvim/lua/user -- --depth=1
sed -i '/require \"mappings\"/a require \"user.init\"' ~/.config/nvim/init.lua
sed -i '/import = \"plugins\"/a \{ import = \"user.plugins\" \}' ~/.config/nvim/init.lua


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
