# Place this at the end of your system's .bashrc file
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi
