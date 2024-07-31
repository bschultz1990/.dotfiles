# Installation

## Bash
**Place the following inside your system's ~/.bashrc file:
```bash
# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/ ]; then
    for file in ~/.dotfiles/bash/bash_scripts/*; do
        . $file
    done
fi

- Reload your shell
