#!/usr/bin/bash

function fan() {
  PS3="MACFANCTL"
  PS3="Select an option: "
  options=("1. Start fan service" "2. Stop fan service" "3. Edit config file" "4. Install mbpfan" "5. Exit")
    select choice in "${options[@]}"
    do
      case $choice in
        "1. Start fan service")
          sudo systemctl start macfanctld
          break
          ;;
        "2. Stop fan service")
          sudo systemctl stop macfanctld
          break
          ;;
        "3. Edit config file")
          sudo nvim /etc/macfanctl.conf
          break
          ;;
        "4. Install mbpfan")
          sudo pamac install macfanctld
          break
          ;;
        "5. Exit")
          break
          ;;
      esac
    done
  }
