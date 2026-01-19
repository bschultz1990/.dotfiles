#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../base/functions.sh"

update()
{
  if ! requirements "snap"; then
    return
  else
    echo "UPDATING SYSTEM..."
    sudo apt update -y
    sudo apt upgrade -y
    echo "CLEANING LOCAL PACKAGES..."
    sudo apt autoremove
    echo "CLEANING SNAP PACKAGES..."
    snap refresh
    #TODO: Is there a way to clean up unused snaps?
    update_neovim
  fi
}
