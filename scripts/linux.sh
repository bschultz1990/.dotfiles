#!/bin/bash

echo "Installing extra applications..."
# Mac Specific Apps
brew install --cask rectangle
brew install --cask iterm2
brew install --cask ao # Microsoft To Do Client

open "/Applications/Rectangle.app"
