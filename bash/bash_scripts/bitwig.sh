#!/usr/bin/bash

# Show version info
flatpak remote-info --log flathub com.bitwig.BitwigStudio

# If Bitwig exists and its version is less than 6, return.

# Else, install Bitwig

flatpak install bitwig -y

# Downgrade to Bitwig v. 5.3.13
sudo flatpak update --commit=00535d779d2ebead55f129a406ed819064b7d3a28bd638aa25a0c8dda919197e com.bitwig.BitwigStudio -y

# Block Bitwig from updating
flatpak mask com.bitwig.BitwigStudio
