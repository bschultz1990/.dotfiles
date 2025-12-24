#!/usr/bin/bash

# Enter your name and email for git config later
echo "Enter your name:"; read user_name
echo "Enter your email:"; read user_email
echo "Name: $user_name"; echo "Email: $user_email"


echo "Enabling the AUR and Flatpacks..."
sleep 1
sudo sed -i '/EnableAUR\|CheckAURUpdates\|CheckFlatpakUpdates\|EnableFlatpak/s/^#//' /etc/pamac.conf


echo "Installing Fan Control..."
sudo pamac install macfanctld --no-confirm
sleep 1
sudo sed -i '/fan_min/s/\(: \).*/\13500/g' /etc/macfanctl.conf
sudo systemctl enable macfanctld
sudo systemctl start macfanctld


echo "Performing a full system upgrade..."
sleep 1
kill $(pgrep firefox)
sudo pacman -Syyu -y

sudo pamac install glab github-cli --no-confirm

echo "Replacing Vivaldi with Firefox..."
sleep 1
sudo pamac remove vivaldi --no-confirm
sudo pamac install firefox --no-confirm

echo "Configuring git, gh, and glab..."
sleep 1
git config --global user.name $user_name
git config --global user.email $user_email
gh auth login
glab auth login

echo "Installing .dotfiles and configuring ~/.bashrc..."
cd ~/
gh repo clone .dotfiles
echo '

# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/manjaro/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/manjaro/*; do
        . $file
    done
fi' >> ~/.bashrc


echo "Installing Neovim and friends..."
sleep 1
echo "nvim:";sudo pamac install nvim --no-confirm
echo "fzf";sudo pamac install fzf --no-confirm
echo "xclip";sudo pamac install xclip --no-confirm
echo "npm";sudo pamac install npm --no-confirm
echo "ripgrep";sudo pamac install ripgrep --no-confirm
echo "tree-sitter";sudo pamac install tree-sitter tree-sitter-cli --no-confirm


echo "Installing other apps..."
sleep 1
sudo pamac install fastfetch getnf gnome-font-viewer --no-confirm


echo "Downloading notes..."
gh repo clone notes ~/Documents/notes


echo "Installing starship prompt..."
sudo pamac install starship --no-confirm
echo 'eval "$(starship init bash)"
export STARSHIP_CONFIG=~/.dotfiles/starship/starship.toml' >> ~/.bashrc

echo "Installing Typst and friends..."
sudo pamac install typst

echo "Installing pipx and pyrefly"
sudo pamac install python-pipx
pipx install pyrefly
