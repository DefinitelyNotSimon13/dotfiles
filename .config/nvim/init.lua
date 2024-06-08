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
