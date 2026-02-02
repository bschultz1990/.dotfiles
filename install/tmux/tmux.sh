#!/bin/bash
# Install tmux
sudo apt install tmux -y

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Check for tmux config directory and create if it doesn't exist.
if ! [ -d ~/.config/tmux ]; then
  mkdir ~/.config/tmux
fi

# Create symlink to existing tmux config file
# This will gracefully fail if the link already exists
ln -s ~/.dotfiles/tmux/tmux.conf ~/.config/tmux/tmux.conf


