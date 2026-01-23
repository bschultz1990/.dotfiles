# DOTFILES_BASE_SNIPPET_START
if [ -d ~/.dotfiles/bash/bash_scripts/base ]; then
  for file in ~/.dotfiles/bash/bash_scripts/base/*.sh; do
    . $file
  done
fi
# DOTFILES_BASE_SNIPPET_END
