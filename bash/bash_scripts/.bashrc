export FZF_DEFAULT_COMMAND='rg --hidden -l ""'


source_files() {
  local source_dir="$1"
  if [ -d "$source_dir" ]; then
    for file in "$source_dir"/*.sh; do
      [ -e "$file" ] || continue
      . "$file"
    done
  fi
}


source_files "$HOME/.dotfiles/bash/bash_scripts/base" 
source_files "$HOME/.dotfiles/bash/bash_scripts/pikaos"


link_dirs() {
  local source_dir="$1"
  local dest_dir="$2"

  if [ -d "$dest_dir" ]; then
    # This fails gracefully if the directory is not empty.
    rmdir "$dest_dir"
  fi

  ln -s "$source_dir" "$dest_dir"
}

link_dirs "$HOME/Documents" "/mnt/data/Files/Documents/Repositories/nvim"
link_dirs "$HOME/Documents" "/mnt/data/Files/Documents"
link_dirs "$HOME/Pictures" "/mnt/data/Files/Pictures"
link_dirs "$HOME/.dotfiles" "/mnt/data/Files/Documents/Repositories/.dotfiles"

