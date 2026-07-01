ZPLUGINDIR="${ZDOTDIR:-$HOME/.config/zsh}/plugins"

_zplugin_load() {
  local plugin_path="${ZPLUGINDIR}/${2}"
  if [[ ! -d "$plugin_path" ]]; then
    mkdir -p "$ZPLUGINDIR"
    echo -e "\e[1mInstalling ${2}...\e[0m"
    echo -en "\e[2;3m"
    git clone --depth=1 "https://github.com/${1}/${2}" "$plugin_path" \
      || { echo -e "\e[1;30mERROR: failed to install ${2}\e[0m" >&2; return 1;}
    echo -en "\e[0m"
  fi
  source "${plugin_path}/${2}.plugin.zsh"
}

zplugin-update() {
  local dir
  for dir in "${ZPLUGINDIR}"/*/; do
    echo "\e[1mUpdating ${dir:t}...\e[0m"
    echo -en "\e[2;3m"
    git -C "$dir" pull --ff-only
    echo -en "\e[0m"
  done
}

_zplugin_load zdharma-continuum fast-syntax-highlighting
_zplugin_load zsh-users zsh-completions
_zplugin_load zsh-users zsh-autosuggestions
_zplugin_load zsh-users zsh-history-substring-search
_zplugin_load jeffreytse zsh-vi-mode
_zplugin_load Aloxaf fzf-tab
_zplugin_load wbingli zsh-wakatime

