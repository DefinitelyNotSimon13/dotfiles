copy-command() {
  echo -n $BUFFER | wl-copy
  zle -M "Copied to clipboard"
}
zle -N copy-command

nvim() {
  if [ $# -eq 0 ]; then
    local file
    file=$(fzf)

    if [ -n "$file" ]; then
      print -s -- "nvim $file"
      command nvim "$file"
    fi
  else
    command nvim "$@"
  fi
}

switch () {
  pushd $NH_FLAKE || echo "Failed to open flake dir" >&2
  just switch
  popd || echo "Failed to return to initial dir" >&2
}
