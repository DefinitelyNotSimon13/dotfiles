ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
PS1=""

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light wbingli/zsh-wakatime
zinit light jimhester/per-directory-history
zinit light hlissner/zsh-autopair
zinit light fdellwing/zsh-bat
zinit light zpm-zsh/colorize
zinit light ChrisPenner/copy-pasta
zinit light QuarticCat/zsh-smartcache
zinit light zshzoo/iwd
zinit light MichaelAquilina/zsh-you-should-use
zinit light mbenford/zsh-tmux-auto-title
zinit light romkatv/zsh-defer

zinit snippet https://codeberg.org/DefinitelyNotSimon/sudo-zsh-plugin-fork/raw/branch/main/sudo.plugin.zsh
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit snippet OMZP::git
zinit snippet OMZP::archlinux
zinit snippet OMZP::docker-compose
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
zinit snippet OMZP::man
zinit snippet OMZP::tldr
zinit snippet OMZP::thefuck
zinit snippet OMZP::systemd
zinit snippet OMZP::tmuxinator

autoload -U compinit && compinit

zinit cdreplay -q

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bold
zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'

# Initialize oh my posh
zsh-defer eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/config.toml)"


bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^g' per-directory-history-toggle-history

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


alias vim=nvim
alias vi=nvim
alias t=tmux
alias te="tmux kill-session && exit"
alias ls="exa --icons --group-directories-first"
alias ll="exa --long --git --icons --group-directories-first"
alias tree="exa --tree --icons --group-directories-first"
alias la="exa --all --icons --group-directories-first"
alias lla="exa --long --all --icons --group-directories-first"
alias cat=bat
alias zz="cd -"
alias lg="lazygit"
alias :q="exit"
alias cl="clear"
alias c="clear"
alias n="nvim"
alias tx="tmuxinator"
alias killme="shutdown now"
alias uvenv="source .venv/bin/activate"

alias neorg="nvim -c \"Neorg workspace notes\""

path+=("$HOME/.scripts/bin")
path+=("$HOME/.bin")
path+=("$HOME/.cargo/bin")
path+="$(go env GOPATH)/bin"
export LFS=/mnt/lfs
export EDITOR=nvim
export DOTFILES_DIR="$HOME/dotfiles"
export GPG_TTY=$(tty)

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval $(thefuck --alias)

alias nvims="ns"
ns () {
	if [[ -f "./Session.vim" ]]; then
	    nvim -S Session.vim -c 'lua vim.g.savesession = true'
	else
	    nvim -c 'lua vim.g.savesession = true' "$@"
	fi
}

windows () {
    sudo grub-reboot "$(sudo grep -i windows /boot/grub/grub.cfg|cut -d"'" -f2)" && sudo reboot
}

nsh () {
    csh $1
    nvim $1
}

csh() {
    if [ -z "$1" ]; then
        echo "Usage: create_sh filename.sh"
        return 1
    fi
    touch "$1" && chmod +x "$1"
    echo "#!/bin/bash" > "$1"
    echo "Executable file '$1' created."
}

z () {
    zathura "$@" & disown
}

_zathura_completion() {
    _files -g '*.pdf'
}

compdef _files ns
compdef _zathura_completion z

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
