ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

ZVM_VI_HIGHLIGHT_BACKGROUN=none
ZVM_VI_HIGHLIGHT_FOREGROUND=none
ZVM_VI_HIGHLIGHT_EXTRASTYLE=none

bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '^[OA' up-line-or-beginning-search
bindkey -M viins '^[OB' down-line-or-beginning-search

bindkey -M vicmd '^[[A' up-line-or-beginning-search
bindkey -M vicmd '^[[B' down-line-or-beginning-search
bindkey -M vicmd '^[OA' up-line-or-beginning-search
bindkey -M vicmd '^[OB' down-line-or-beginning-search

bindkey -M viins '^F' _fzf_file_no_hidden
bindkey -M viins '^Xa' autosuggest-toggle
bindkey -M viins '^Xe' edit-command-line
bindkey -M viins '^Xc' copy-command
bindkey -M viins ' ' magic-space
