return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  cond = not vim.g.vscode,
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = true },
}
