return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
    }
    -- restore the session for the current directory
    vim.api.nvim_set_keymap('n', '<leader>ps', [[<cmd>lua require("persistence").load()<cr>]], {})

    -- restore the last session
    vim.api.nvim_set_keymap('n', '<leader>pl', [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

    -- stop Persistence => session won't be saved on exit
    vim.api.nvim_set_keymap('n', '<leader>pd', [[<cmd>lua require("persistence").stop()<cr>]], {})
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
