local M = {}
M.base46 = {
  theme = 'catppuccin',
}

M.ui = {
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
