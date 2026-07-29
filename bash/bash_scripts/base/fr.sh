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
    app=$(flatpak list --columns=name,application | fzf --query="'$1"| awk '{print $2}')
    flatpak run --filesystem=host "$app" "$2" >/dev/null 2>&1 &
    disown
  fi
}
