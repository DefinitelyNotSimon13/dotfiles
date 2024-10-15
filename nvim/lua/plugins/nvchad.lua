local M = {
  { 'nvchad/volt', lazy = true },
  { 'nvchad/minty', lazy = true },
  { 'nvchad/menu', lazy = true },
  {
    'nvchad/ui',

    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require 'nvchad'
    end,
  },
  {
    'NvChad/base46',
    lazy = true,
    build = function()
      require('base46').load_all_highlights()
    end,
  },
}
vim.keymap.set('n', '<C-t>', function()
  require('menu').open 'default'
end, { desc = 'Menu' })
vim.keymap.set('n', '<RightMouse>', function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  require('menu').open('default', { mouse = true })
end, {})
return M
