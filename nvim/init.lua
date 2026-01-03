require 'options'
require 'keymaps'

require 'config.lazy'

require 'autocommands'
require 'diagnostics'
require 'lsp'

vim.cmd.colorscheme 'gruvbox'
vim.opt.termguicolors = true

vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'

if not vim.g.vscode then
  -- require('oil').setup()
else
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '
end
