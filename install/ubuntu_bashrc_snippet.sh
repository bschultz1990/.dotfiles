
# Bash Scripts
if [ -d ~/.dotfiles/bash/bash_scripts/base ]; then
  for file in ~/.dotfiles/bash/bash_scripts/base/*.sh; do
    . $file
  done
fi

if [ -d ~/.dotfiles/bash/bash_scripts/ubuntu ]; then
  for file in ~/.dotfiles/bash/bash_scripts/ubuntu/*.sh; do
    . $file
  done
fi

