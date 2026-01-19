#!/bin/bash

sessions="$HOME/Documents/nvim_sessions/sessions.txt"

Warp()
{
  if ! requirements "fzf" "sed"; then
    return
  else
    cd "$(eval echo $(cat "$sessions" | fzf))"
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
