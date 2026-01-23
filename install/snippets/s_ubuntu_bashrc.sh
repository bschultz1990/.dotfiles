# DOTFILES_UBUNTU_SNIPPET_START
if [ -d ~/.dotfiles/bash/bash_scripts/ubuntu ]; then
  for file in ~/.dotfiles/bash/bash_scripts/ubuntu/*.sh; do
    . $file
  done
fi
# DOTFILES_UBUNTU_SNIPPET_END
