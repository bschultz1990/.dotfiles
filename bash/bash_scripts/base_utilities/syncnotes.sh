#! /usr/bin/bash

syncnotes()
{
  if ! requirements "unzip" "gio"; then return; fi

  watchPath="$HOME/Downloads"
  watchFile="notes.zip"
  destPath="$HOME/Documents/Repositories"
  destFolder="notes"
  if [ ! -e "$watchPath/$watchFile" ]; then
    echo "'$watchPath/$watchFile' does not exist. Exiting..."
    return
  fi

  if [ -d "$destPath/$destFolder" ]; then
    gio trash "$destPath/$destFolder"
    echo "Moved '$destPath/$destFolder' to the trash."
  fi

  unzip "$(realpath "$watchPath/$watchFile")" -d "$destPath"
}
