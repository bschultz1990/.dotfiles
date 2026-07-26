downloadGitHubAppImage() {
  # ----------
  # ARGUMENTS
  # ----------
  # repo slug
  # 0-n index # of url
  # app name
  # ----------

  if ! requirements "curl" "jq"; then return; fi

  echo
  destination="/usr/local/bin/"
  repo=$1

  download_url=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" \
    | jq -r ".assets[$2].browser_download_url")

  if [[ -z "$download_url" ]]; then
    echo "No matching asset found" >&2
    return 1
  fi

  out="${download_url##*/}"
  curl -L -o "$out" "$download_url"
  chmod +x "$out"
  echo "Downloaded $out"
  chmod u+x "$out" # Make executable by the user
  sudo mv -f ./"$out" "$destination$3" # Force move with -f. Use the user-provided name.
}
