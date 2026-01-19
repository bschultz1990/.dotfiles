#!/usr/bin/bash

# Enter your name and email for git config later
echo "Enter your name:"; read user_name
echo "Enter your email:"; read user_email
echo "Name: $user_name"; echo "Email: $user_email"


echo "Enabling the AUR and Flatpacks..."
sleep 1
sudo sed -i '/EnableAUR\|CheckAURUpdates\|CheckFlatpakUpdates\|EnableFlatpak/s/^#//' /etc/pamac.conf


echo "Installing Fan Control..."
pamac install macfanctld --no-confirm
sleep 1
sudo sed -i '/fan_min/s/\(: \).*/\13500/g' /etc/macfanctl.conf
sudo systemctl enable macfanctld
sudo systemctl start macfanctld


echo "Performing a full system upgrade..."
sleep 1
kill $(pgrep firefox)
sudo pacman -Syyu -y

pamac install glab github-cli --no-confirm

echo "Replacing Vivaldi with Firefox..."
sleep 1
pamac remove vivaldi --no-confirm
pamac install firefox --no-confirm

echo "Configuring git, gh, and glab..."
sleep 1
git config --global user.name $user_name
git config --global user.email $user_email
gh auth login
glab auth login

echo "Installing .dotfiles and configuring ~/.bashrc..."
cd "$HOME" || return 1
gh repo clone .dotfiles
echo "

# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/manjaro/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/manjaro/*.sh; do
        . $file
    done
fi

if [ -d ~/.dotfiles/bash/bash_scripts/base/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/base/*.sh; do
        . $file
    done
fi">> ~/.bashrc


echo "Installing Neovim and friends..."
sleep 1
echo "nvim:";pamac install nvim --no-confirm
echo "fzf";pamac install fzf --no-confirm
echo "xclip";pamac install xclip --no-confirm
echo "npm";pamac install npm --no-confirm
echo "ripgrep";pamac install ripgrep --no-confirm
echo "tree-sitter";pamac install tree-sitter tree-sitter-cli --no-confirm


echo "Installing other apps..."
sleep 1
pamac install fastfetch getnf gnome-font-viewer --no-confirm


echo "Downloading notes..."
gh repo clone notes ~/Documents/notes


echo "Installing starship prompt..."
pamac install starship --no-confirm
echo 'eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml' >> ~/.bashrc

echo "Installing Typst..."
pamac install typst
