#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../bash/bash_scripts/base/requirements.sh"

write_snippet () {
  if ! requirements "basename" "head" "cat"; then return; fi
  if rg "$(head --lines 1 "$1")" ~/.bashrc -q; then
    return
  fi
  echo "Writing snippet from $(basename "$1") to .bashrc"
  cat "$1" >> ~/.bashrc
}


write_bashrc () {
  if ! requirements "rg"; then return; fi

  script_dir=$(realpath "$(dirname "$0")")

  if [ ! -f ~/.bashrc ]; then
    echo "Creating ~/.bashrc file"
    touch ~/.bashrc
    chmod u+x ~/.bashrc
  fi

  write_snippet "$script_dir/snippets/s_base_bashrc.sh"
  write_snippet "$script_dir/snippets/s_ubuntu_bashrc.sh"
}
