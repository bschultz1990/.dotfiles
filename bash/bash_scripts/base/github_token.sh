function auth_gh_token ()
{
  if ! requirements "bw" "sed" "xclip"; then
    return
  else
    bw get notes github.com | sed -n '2p' | xclip -selection clipboard
    echo "Token copied to clipboard."
  fi
}
