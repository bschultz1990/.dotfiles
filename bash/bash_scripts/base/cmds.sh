#!/bin/bash

cmds_path="$HOME/Documents/cmds.txt"

cmds()
{
  if ! requirements "fzf" "sed"; then
    return
  else
    cat "$cmds_path" | fzf
  fi
}


cmdsEdit()
{
  if ! requirements "nvim"; then
    return
  else
    nvim "$cmds_path"
  fi
}
