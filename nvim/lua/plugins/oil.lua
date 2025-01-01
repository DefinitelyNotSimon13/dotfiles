return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    require('oil').setup {
      skip_confirm_for_simple_edits = true,
      lsp_file_methods = {
        enabled = true,
      },
    }
  end,
}
