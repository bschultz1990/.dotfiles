#! /usr/bin/bash
backup() {
  if ! requirements "b2"; then return; fi
  directory="/mnt/data/Files/"
  cd "$directory" || echo "Error: $directory does not exist"
  b2 sync --keep-days 30 --replace-newer . b2:JediArchiveBackup/FalconII/
}
