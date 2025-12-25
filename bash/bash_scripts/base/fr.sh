#!/usr/bin/bash

# Flatpak Run. Using the power of fzf and sed to launch things.
# flatpak run com.slack.Slack
# flatpak list --columns=name,application

function fr ()
{
  if ! requirements "awk" "flatpak" "fzf"; then
    return
  else
    local app
    app=$(flatpak list --columns=name,application | fzf | awk '{print $2}')
    flatpak run "$app"
  fi
}
