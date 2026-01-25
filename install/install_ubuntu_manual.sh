#!/bin/bash
function requirements ()
{
  notinstalled=()
  local requirements=("$@") # Capture all args as array
  for cmd in "${requirements[@]}"
  do
    if ! command -v "$cmd" &> /dev/null; then
      notinstalled+=("$cmd")
    fi
  done
  if [ ${#notinstalled[@]} -gt 0 ]; then
    echo "The following applications are not installed. Install before continuing:"
    echo ""
    printf "%s\n" "${notinstalled[@]}"
    return 1
  fi
}

echo "Installing prerequisites"

sudo apt install macfanctld -y
sudo apt install git -y
sudo apt install curl -y
sudo apt install wget -y
sudo apt install glab -y
sudo apt install gh -y
# gh auth login
# glab auth login
sudo apt install fzf -y
sudo apt install ripgrep -y
sudo apt install wget -y
sudo apt install xclip -y

update_neovim() {
  nvim_filename='nvim-linux-x86_64.appimage'

  curl -LO https://github.com/neovim/neovim/releases/latest/download/$nvim_filename
  chmod u+x $nvim_filename
  sudo mv $nvim_filename /usr/local/bin/nvim
  nvim --version
}

update_neovim 

install_fontmanager () {
  # Install Font Manager
  sudo apt install font-manager
  cd "$HOME/Downloads" || return
  font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"
  font_zip_name="${font_url##*/}"
  wget "$font_zip_name"
  echo "Installing $font_zip_name and refreshing font cache..."
  
  font-manager -i 
  fc-cache -fv
}

install_fontmanager

install_node () {
  echo "MANUALLY install NodeJS and npm"
  echo "Redirecting to 'https://nodesource.com/products/distributions'"
  echo "For more updated instructions"
  nohup xdg-open "https://nodesource.com/products/distributions" >/dev/null 2>&1 &
}

write_bashrc () {
  cat "
  # DOTFILES_BASE_SNIPPET_START
if [ -d ~/.dotfiles/bash/bash_scripts/base ]; then
  for file in ~/.dotfiles/bash/bash_scripts/base/*.sh; do
    . $file
  done
fi
# DOTFILES_BASE_SNIPPET_END
# DOTFILES_UBUNTU_SNIPPET_START
if [ -d ~/.dotfiles/bash/bash_scripts/ubuntu ]; then
  for file in ~/.dotfiles/bash/bash_scripts/ubuntu/*.sh; do
    . $file
  done
fi
# DOTFILES_UBUNTU_SNIPPET_END

" >> ~/.bashrc
}

write_bashrc
