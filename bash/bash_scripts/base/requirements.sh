#!/usr/bin/bash
# if ! requirements "list" "of" "apps"; then
#   return
# else
#   do stuff
# fi
#
# Checks for installed apps on Linux. Return 1 if any aren't installed.
# Inform the user which ones need to be installed yet.
function requirements ()
{
  notinstalled=()
  local requirements=("$@") # Capture all args as array
  for cmd in "${requirements[@]}"
  do
    if ! command -v "$cmd" &> /dev/null; then
      notinstalled+=("$cmd")
    fi
  done
  if [ ${#notinstalled[@]} -gt 0 ]; then
    echo "The following applications are not installed. Install before continuing:"
    echo ""
    printf "%s\n" "${notinstalled[@]}"
    return 1
  fi
}
