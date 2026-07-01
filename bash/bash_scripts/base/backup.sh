#! /usr/bin/bash
backup() {
  if ! requirements "b2"; then return; fi
  directory="/mnt/data/Files/"
  bucket="JediArchiveBackup/FalconII/"
  cd "$directory" || echo "Error: $directory does not exist"
  b2 sync --keep-days 30 --replace-newer . b2:$bucket
}
