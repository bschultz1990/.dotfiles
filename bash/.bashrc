# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi
