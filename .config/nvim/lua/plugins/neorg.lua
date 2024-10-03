return {
  'nvim-neorg/neorg',
  lazy = false,
  version = '*',
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.completion'] = { config = { engine = 'nvim-cmp' } },
        ['core.summary'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
              db = '~/notes/databases',
              networks = '~/notes/networks',
            },
            default_workspace = 'notes',
          },
        },
      },
    }

    vim.keymap.set('n', '<leader>nr', '<cmd>Neorg return<CR>', { desc = 'Neo return' })
    vim.keymap.set('n', '<leader>nd', '<cmd>Neorg workspace notes<CR>', { desc = 'Notes workspace' })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
