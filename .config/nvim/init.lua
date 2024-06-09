-- "<space>sh" to [s]earch the [h]elp documentation

-- Options
require 'options'

-- Keymaps
require 'keymaps'

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
vim.cmd.colorscheme 'catppuccin'
vim.cmd.hi 'Comment gui=none'
require('notify').setup {
  background_colour = '#000000',
  render = 'wrapped-compact',
}

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
