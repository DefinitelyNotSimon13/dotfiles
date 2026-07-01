if _has batcat; then
  alias -- bat=batcat
fi

compdef eza=ls
compdef bat=cat

alias -- n='nvim'
alias -- t='tmux'
alias -- c='clear'
alias -- cl='clear'
alias -- z='zathura'
alias -- :q='quit'
alias -- killme='shutdown now'

alias -- ls='eza --icons'
alias -- ll='eza -lh --icons --git'
alias -- la='eza -a --icons --git'
alias -- lla='eza -lah --icons --git'
alias -- tree='eza --tree --icons'

alias -- ds='devenv shell'


alias -- cat='bat -p'
alias -- find='fd'

alias -- grep='rg --color=auto'
alias -- df='df -h'

alias -- ga='git add'
alias -- gap='ga --patch'
alias -- gb='git branch'
alias -- gba='gb --all'
alias -- gc='git commit'
alias -- gca='gc --amend --no-edit'
alias -- gce='gc --amend'
alias -- gs='git switch'
alias -- gco='git checkout'
alias -- gcl='git clone --recursive'
alias -- gd=''git diff --output-indicator-new=" " --output-indicator-old=" "''
alias -- gds='gd --staged'
alias -- gi='git init'
alias -- gl=''git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"''
alias -- gm='git merge'
alias -- gn='git switch -c';
alias -- gp='git push'
alias -- gr='git reset'
alias -- gs='git status --short'
alias -- gu='git pull'

alias -- view='kitty +kitten icat'
alias -- open='xdg-open'

alias -- -='cd -'

alias -s -- md='bat'
alias -s -- png='open'
alias -s -- jpeg='open'
alias -s -- jpg='open'
alias -s -- mp4='open'
alias -s -- json='jless'
alias -s -- yaml='bat -l yaml'
alias -s -- html='open'
alias -s -- pdf='open'

alias -g -- NE='2>/dev/null'
alias -g -- ND='>/dev/null'
alias -g -- NUL='>/dev/null 2>&1'
alias -g -- JQ='| jq'
alias -g -- C='| wl-copy'

