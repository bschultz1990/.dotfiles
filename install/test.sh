#!/usr/bin/env bash

source functions.sh

set_manager

pkginstall rectangle --cask
pkginstall glow

# if ! type "$1" &> /dev/null; then 
#   echo "Installing package: " "$package..."
#   if [ "$2" == "--cask" ] && [ "$system" == "Darwin" ]; then
#     echo "Cask on Mac!"
#     ${install_command[@]} $2 "$package" ${suffix[@]}
#   else
#     ${install_command[@]} "$package" ${suffix[@]}
#   fi
# else
#   echo "$1" "is already installed. Skipping install of" "$package"
# fi

# function pkginstall {
#   # Warn user and exit if 'jq' is not installed.
#   if ! which "jq" &> /dev/null; then
#     echo "FATAL: 'jq' is not installed. Please install before running this script again."
#     exit
#   else
#     package=$(jq -r ".[\"$1\"].\"$option\"" packages.json)
#     if ! type "$1" &> /dev/null; then 
#       echo "Installing package: " "$package..."
#       if [ "$2" == "--cask" ] && [ "$system" == "Darwin" ]; then
#         echo "Cask on Mac!"
#         ${install_command[@]} $2 "$package" ${suffix[@]}
#       else
#         ${install_command[@]} "$package" ${suffix[@]}
#       fi
#     else
#       echo "$1" "is already installed. Skipping install of" "$package"
#     fi
#   fi
# }
