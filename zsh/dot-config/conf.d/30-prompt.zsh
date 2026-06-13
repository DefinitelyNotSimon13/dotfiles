eval "$(starship init zsh)"

add-zsh-hook precmd _remove_devenv_prompt_prefix

_remove_devenv_prompt_prefix() {
  PROMPT="${PROMPT/#$'(devenv)\n'/}"
  PROMPT="${PROMPT/#'(devenv) '/}"
  PS1="$PROMPT"
}

_starship_prompt_profile() {
  local profile="$1"

  command starship prompt \
    --profile "$profile" \
    --terminal-width="${COLUMNS:-80}" \
    --keymap="${KEYMAP:-}" \
    --status="${STARSHIP_CMD_STATUS:-0}" \
    --pipestatus="${STARSHIP_PIPE_STATUS[*]}" \
    --cmd-duration="${STARSHIP_DURATION:-0}" \
    --jobs="${STARSHIP_JOBS_COUNT:-0}"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd transient-prompt-precmd

function transient-prompt-precmd {
  TRAPINT() {
    transient-prompt
    return $((128 + $1))
  }

  SAVED_PROMPT="$(_starship_prompt_profile transient)"

  SAVED_RPROMPT="$(_starship_prompt_profile rtransient)"
  SAVED_RPROMPT="${SAVED_RPROMPT//$'\n'/}"
}

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-finish transient-prompt

function transient-prompt() {
  [[ -n ${WIDGET-} ]] || return 0

  PROMPT="$SAVED_PROMPT" RPROMPT="$SAVED_RPROMPT" zle .reset-prompt
}
