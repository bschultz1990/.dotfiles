#!/usr/bin/env bash

# Get system name to help set default values
system="$(uname -s)"

function set_manager {
  # TODO: Add an 'are you sure?' prompt before making a final choice.
  # TODO: Add a safety on old Betsy. Actually check for the platform
  # compatibility and check if the package manager in question is installed first.
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

function pkginstall {
  echo ""
  # Exit if 'jq' isn't installed
  if ! which "jq" &> /dev/null; then
    echo "FATAL: 'jq' is not installed. Please install before running this script again."
    exit
  fi
  package=$(jq -r ".[\"$1\"].\"$option\"" packages.json)
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

# Create the Apps directory if it doesn't exist already.
function set_appdir {
  if [ ! -e "$HOME/Apps" ]; then
    mkdir "$HOME/Apps"
    echo "$HOME/Apps directory created!"
  fi
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
    brew install --cask macs-fan-control
    open "/Applications/Macs Fan Control"

    # Antidote zsh plugin manager
    brew install antidote git-credential-manager-core
  fi
}

function get_terminal {
  if [ "$(uname -s)" = "Linux" ] && [ "$option" = "apt" ]; then
    flatpak install flathub org.wezfurlong.wezterm
    flatpak run org.wezfurlong.wezterm
  fi
  pkginstall terminal
}

function hello {
  echo "Hello! I'm not supposed to run if jq is not installed. Teehee!"
}

