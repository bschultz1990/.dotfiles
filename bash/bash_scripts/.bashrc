base_dir="$HOME/.dotfiles/bash/bash_scripts/base"
if [ -d "$base_dir" ]; then
  for file in "$base_dir"/*.sh; do
    [ -e "$file" ] || continue
    . "$file"
  done
fi


pikaos_dir="$HOME/.dotfiles/bash/bash_scripts/pikaos"
if [ -d "$pikaos_dir" ]; then
  for file in "$pikaos_dir"/*.sh; do
    [ -e "$file" ] || continue
    . "$file"
  done
fi

export FZF_DEFAULT_COMMAND='rg --hidden -l ""'

