#!/bin/bash

# source install.sh

# Get system name to help set default values
system="$(uname -s)"


# Set default package manager
# if [ "$(uname -s)" = "Linux" ]; then
#   pkg_manager=(sudo apt install)
#   suffix=(-y)
# elif [ "$(uname -s)" = "Darwin" ]; then
#   pkg_manager=(brew install)
# fi

function set_manager {
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
        suffix=(-y)
        ;;
      pacman)
        install_command=(sudo pacman -S)
        suffix=(-y)
        ;;
      brew)
        install_command=(brew install)
        suffix=()
        ;;
      nix)
        install_command=(nix-env -iA)
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
  echo "Your suffix is" ${suffix[@]}
}

function pkginstall {
  # TODO: Refactor this to be conscious of the package manager's install command.
  package=$(jq -r ".$1.$option" packages.json)
  echo "Installing package: " "$package""..."
  ${install_command[@]} $package ${suffix[@]}
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
  case $option in
    "Nala")
      echo "Nala package manager"
      sudo nala update
      sudo nala upgrade -y
      ;;

    "Apt")
      echo "apt package manager"gh
      sudo apt update
      sudo apt upgrade -y
      ;;

    "Pacman")
      echo "Pacman package manager"
      sudo pacman -Syu
  esac

  # Update Mac environment...
  if [ "$(uname -s)" = "Darwin" ]; then
    # Install Brew if it doesn't exist already.
    if type "brew" !&> /dev/null; then
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

function get_wezterm {
  flatpak install flathub org.wezfurlong.wezterm
  flatpak run org.wezfurlong.wezterm
}
