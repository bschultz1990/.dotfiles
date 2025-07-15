function auth_gh_token ()
{
  notinstalled=()
  requirements=('bw' 'sed' 'xclip')
  for cmd in "${requirements[@]}"
  do
    if ! command -v "$cmd" &> /dev/null; then
      notinstalled+=("$cmd")
    fi
  done
  if [ ${#notinstalled[@]} -gt 0 ]; then
    echo "The following commands are not installed. Install before continuing."
    printf "%s\n" "${notinstalled[@]}"
  else
    bw get notes github.com | sed -n '2p' | xclip -selection clipboard
    echo "Token copied to clipboard."
  fi
}
