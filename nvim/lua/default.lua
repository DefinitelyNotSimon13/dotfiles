require 'options'

require 'keymaps'

require 'lsp'

require 'plugins.lazy'

require('lazy').setup({ require 'plugins' }, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

vim.cmd.colorscheme 'catppuccin'

vim.api.nvim_create_autocmd('FileType', {
  pattern = {
    'checkhealth',
    'fugitive*',
    'git',
    'help',
    'lspinfo',
    'netrw',
    'notify',
    'qf',
    'query',
  },
  callback = function()
    vim.keymap.set('n', 'q', vim.cmd.close, { desc = 'Close the current buffer', buffer = true })
  end,
})

vim.api.nvim_create_autocmd('VimLeavePre', {
  pattern = '*',
  callback = function()
    if vim.g.savesession then
      vim.api.nvim_command 'mks!'
    end
  end,
})

-- Function to set options for .typ files
local function set_typ_options()
  -- Enable soft wrapping
  vim.opt_local.wrap = true
  -- Break lines at word boundaries
  vim.opt_local.linebreak = true
  -- Allow cursor to move freely through wrapped lines
  vim.opt_local.whichwrap:append 'h,l,<,>,[,],~'
end

-- Create an autocommand to apply settings for .typ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'typst',
  callback = set_typ_options,
})

local function set_md_options()
  vim.cmd.colorscheme 'catppuccin'
end

-- Create an autocommand to apply settings for .typ files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = set_md_options,
})

require('oil').setup()
