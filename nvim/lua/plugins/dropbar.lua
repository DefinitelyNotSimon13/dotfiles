return {
  'Bekaboo/dropbar.nvim',
  cond = not vim.g.vscode,
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
  },
}
