local M = {}
M.base46 = {
  theme = 'catppuccin',
  hl_add = {},
}

M.ui = {
  cmp = {
    style = 'atom',
  },

  statusline = {
    theme = 'vscode_colored',
  },
  telescope = { style = 'borderless' },

  lsp = {
    signature = true,
  },
  tabufline = {
    enabled = false,
  },
}

return M
