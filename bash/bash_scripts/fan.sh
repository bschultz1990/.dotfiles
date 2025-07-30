#!/usr/bin/bash

function fan() {
  PS3="Select an option: "
  options=("1. Start fan service" "2. Stop fan service" "3. Edit config file" "4. Install mbpfan" "5. Exit")
    select choice in "${options[@]}"
    do
      case $choice in
        "1. Start fan service")
          sudo systemctl start mbpfan.service
          break
          ;;
        "2. Stop fan service")
          sudo systemctl stop mbpfan.service
          break
          ;;
        "3. Edit config file")
          sudo vi /etc/mbpfan.conf
          break
          ;;
        "4. Install mbpfan")
          sudo dnf install mbpfan
          break
          ;;
        "5. Exit")
          break
          ;;
      esac
    done
  }
