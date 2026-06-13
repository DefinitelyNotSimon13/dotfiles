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
