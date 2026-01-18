#!/bin/bash

sessions="$HOME/Documents/nvim_sessions/sessions.txt"

Warp()
{
  if ! requirements "fzf"; then
    return
  else
    cd "$(cat "$sessions" | fzf)" || exit 1
  fi
}


WarpEdit()
{
  if ! requirements "nvim"; then
    return
  else
    nvim "$sessions"
  fi
}
