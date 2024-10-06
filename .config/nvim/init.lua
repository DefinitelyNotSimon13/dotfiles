-- "<space>sh" to [s]earch the [h]elp documentation

-- Options
require 'options'

-- Keymaps
require 'keymaps'

vim.g.base46_cache = vim.fn.stdpath 'data' .. '/base46_cache/'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'plugins.lazy'

-- [[ Configure and install plugins ]]
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

require('oil').setup()
-- vim.cmd.colorscheme 'catppuccin'
vim.cmd.hi 'Comment gui=none'

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

for _, v in ipairs(vim.fn.readdir(vim.g.base46_cache)) do
  dofile(vim.g.base46_cache .. v)
end
