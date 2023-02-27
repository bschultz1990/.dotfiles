#!/bin/bash

# update Linux System
if [ "$(uname -s)" = "Linux" ]; then
	echo "Updating Linux"
	sudo apt update && sudo apt upgrade -y
fi

if [ "$(uname -s)" = "Darwin" ]; then
# Create the Apps directory if it doesn't exist already.
if [ ! -e ~/Apps ]; then
	mkdir ~/Apps
	echo "$HOME/Apps directory created!"
fi

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

# Install Nix
sh <(curl -L https://nixos.org/nix/install)

# Find and restart the appropriate shell, sourcing the second script as needed.
echo "Restarting shell and sourcing install2.sh..."
case "$(echo "$SHELL")" in
    */zsh) exec zsh -l -c "./install2.sh";;
    */bash) exec bash -l -c "./install2.sh";;
    *) echo "unknown shell";;
esac
