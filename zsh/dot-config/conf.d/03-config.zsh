mkdir -p "$XDG_STATE_HOME/zsh"
mkdir -p "$XDG_CACHE_HOME/zsh"

HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS

set AUTOCD
set NOBEEP
set NUMERIC_GLOB_SORT

autoload -Uz edit-command-line
zle -N edit-command-line

autoload -Uz zmv

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

hash -d dl=$HOME/Downloads
hash -d dot=$HOME/.dotfiles
hash -d nix=$HOME/.dotfiles/nix

# eval "$(devenv hook zsh)"
