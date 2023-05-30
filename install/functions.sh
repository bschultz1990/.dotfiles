#!/usr/bin/env bash

# Get system name to help set default values
system="$(uname -s)"
messages=()

function antidote_install {
  # Antidote zsh plugin manager
  brew install antidote
  return
}

function cloneme {
  # Clone .dotfiles
  echo "Cloning /.dotfiles"
  cd ~/ || return
  git clone https://github.com/bschultz1990/.dotfiles

  # Clone nvim repo
  echo "Cloning nvim config."
  cd ~/.config || return
  git clone --depth 1 https://github.com/bschultz1990/nvim

  # Clone notes
  echo "Cloning notes"
  cd ~/Documents/ || return
  git clone https://github.com/bschultz1990/notes
}

function get_terminal {
  if [ "$(uname -s)" = "Linux" ] && [ "$option" = "apt" ]; then
    flatpak install flathub org.wezfurlong.wezterm
    flatpak run org.wezfurlong.wezterm
  fi
  pkginstall terminal
}

function getnf {
  cd "$HOME/Apps" || return
  git clone https://github.com/ronniedroid/getnf.git
  cd getnf || return
  ./install.sh
}

function lazygit_install {
  if ! manager_check; then
    echo "manager_check failed."
    return
  fi
  if [ "$option" = "apt" ]; then
    messages+=("LAZYGIT_INSTALL: \nlazygit is not available on 'apt'. \nRun 'set_manager' and choose a different package manager or visit https://github.com/jesseduffield/lazygit for more installation options.")
    return
  fi
  pkginstall lazygit
}

function macs_fan_install {
  brew install --cask macs-fan-control
  open "/Applications/Macs Fan Control"
}

function manager_check {
  if [ "$option" = "" ]; then
    echo "Package manager not set. Run 'set_manager to continue. Aborting."
    return 1
  fi
  return 0
}

function pkginstall {
  echo ""
  # Exit if 'jq' isn't installed
  if ! which "jq" &> /dev/null; then
    echo "FATAL: 'jq' is not installed. Please install before running this script again."
    exit
  fi

  manager_check

  package=$(jq -r ".[\"$1\"].\"$option\"" packages.json)
  echo "Installing $package"

  # Quickly abort installation on installed apps using Mac:
  app=$(jq -r ".[\"$1\"].app" packages.json)
  [ "$app" != null ] && echo "Checking for" "$app" "in /Applications first..."
  if command -v "$1" >/dev/null 2>&1 || [ -e "/Applications/""$app" ]; then
    echo "$1 is already installed. Skipping install of $package"
  else
    echo "Installing package: $package ..."
    [ "$2" == "--cask" ] && [ "$system" == "Darwin" ] && install_command+=( "$2" )
    ${install_command[@]} "$package" "${suffix[@]}"
  fi
}

function set_manager {
  # TODO: Add an 'are you sure?' prompt before making a final choice.
  # TODO: Add a safety on old Betsy. Actually check for the platform
  # compatibility and check if the package manager in question is installed first.
  # FIXME: Dis brokded.Windowed
  PS3="Select your package manager: "
  declare -A choices=(
  ["apt"]="apt"
  ["pacman"]="pacman"
  ["brew"]="brew"
  ["nix"]="nix"
)
select option in "${choices[@]}"; do
  if [[ -n ${choices[$option]} ]]; then
    case $option in
      apt)
        install_command=(sudo apt install)
        update_command=(sudo apt full-upgrade)
        suffix=(-y)
        ;;
      pacman)
        install_command=(sudo pacman -S)
        update_command=(sudo pacman -Syu)
        suffix=(-y)
        ;;
      brew)
        install_command=(brew install)
        update_command=(brew update)
        suffix=()
        ;;
      nix)
        install_command=(nix-env -iA)
        update_command=(nix-env -u '*')
        suffix=()
        ;;
      *)
        suffix=()
        ;;
    esac
    break
    echo "invalid choice. please try again."
  fi
done

  # Use the selected pkg_manager in a command
  echo "You selected '$option', which corresponds to the command '${install_command[*]}'."
  echo "Your suffix is" "${suffix[@]}"
  echo "Your update command is" "${update_command[@]}"
}

function showmsgs {
  #Display messages from other functions.
  for message in "${messages[@]}"; do
    echo "$message"
  done
}

function stowme {
  # Stow the new stuff
  echo "Stowing from .dotfiles..."
  cd ~/.dotfiles || return
  echo "Stowing bash..."
  stow -t ~/ bash
  echo "Stowing Alacritty..."
  stow -t ~/ alacritty
  echo "Stowing zsh..."
  stow -t ~/ zsh
}

function sys_update {
  # update Linux system
  echo "Updating using " "${option[@]}"
  ${update_command[@]} ${suffix[@]}

  # Install and update Brew on Mac if it isn't installed already.
  if [ "$system" == "Darwin" ]; then
    if ! which "brew" &> /dev/null; then
      echo "Installing Homebrew Package Manager..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      # Pause the script and allow the user to input commands 
      echo "Enter your commands or type 'continue' to resume:"
      while true; do
        read -r -p "> " input
        if [ "$input" == "continue" ]; then
          break
        else
          # Execute the user's command
          eval "$input"
        fi
      done
    fi
    echo "Brew installed! Making sure it's ready to Brew..."
    brew update && brew upgrade && brew doctor

  fi
}

function trashconfigs {
  # Trash existing configs
  echo "Trashing existing configs. Recover using 'trash-restore'"
  cd ~/ || return
  trash ~/.bashrc
  trash ~/.zshrc
  trash ~/.zsh_plugins.txt
  trash ~/.zsh_plugins.zsh
  cd ~/.config || return
  trash kitty
  trash alacritty
  trash nvim
}
