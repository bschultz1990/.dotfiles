#Installation
```sh
#!/bin/bash

echo "Installing mbpfan"
sudo dnf install mbpfan -y

echo "

min_fan1_speed = 4000
min_fan2_speed = 4000
max_fan1_speed = 6200
max_fan2_speed = 6200
" | sudo tee -a /etc/mbpfan.conf

sudo systemctl start mbpfan.service
sudo systemctl enable mbpfan
sudo systemctl enable systemd-resolved

echo "Removing LibreOffice and updating system"
sudo dnf remove *libreoffice* -y
sudo dnf update -y
sudo dnf upgrade -y

echo "Installing wireless drivers. Reboot to complete the install."
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install broadcom-wl -y

echo "Installing extras..."
sudo dnf install neovim fzf glab konsole gh glab fastfetch cascadia-mono-nf-fonts -y

echo "Installing .dotfiles and updating ~/.bashrc..."
gh auth login
cd ~/
gh repo clone .dotfiles
echo '

# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi' >> ~/.bashrc


echo "Getting notes..."
cd ~/Documents/
glab auth login
ghab repo clone notes
cd ~/

echo "Configuring Neovim..."
git clone https://github.com/NvChad/starter ~/.config/nvim
sudo rm -r ~/.config/nvim/.git/
gh repo clone nvim ~/.config/nvim/lua/user
vi ~/.config/nvim/init.lua

echo "All done! :) Restart to bask in the full glory of your updates."

```
