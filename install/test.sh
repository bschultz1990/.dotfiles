#!/bin/bash
function options {
# Define the choices as an associative array of arrays
apt=(sudo apt install)
pacman=(sudo pacman -S)
declare -A choices=(
["Apt"]="${apt[@]}"
["Pacman"]="${pacman[@]}"
)

# Prompt the user for their choice
echo "Which package manager do you use?"
select option in "${!choices[@]}"; do
  # Check that the user has selected a valid option
  if [[ -n ${choices[$option]} ]]; then
    pkg_manager=("${choices[$option]}")
    break
  else
    echo "Invalid choice. Please try again."
  fi
done

# Use the selected pkg_manager in a command
echo "You selected '$option', which corresponds to the command '${pkg_manager[*]}'."
}
