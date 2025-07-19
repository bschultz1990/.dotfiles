#!/bin/bash

readonly sessions='/home/bens/Documents/nvim_sessions/sessions.txt'

Warp()
{
  cd $(cat $sessions | fzf)
}


WarpEdit()
{
  nvim $sessions
}
