#!/bin/bash

readonly sessions='/home/bens/Documents/nvim_sessions/sessions.txt'

Warp()
{
  if ! requirements "fzf"; then
    return
  else
    cd $(cat $sessions | fzf)
  fi
}


WarpEdit()
{
  if ! requirements "nvim"; then
    return
  else
    nvim $sessions
  fi
}
