return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
  },
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  config = function()
    local oil = require 'oil'
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>-', "<CMD>lua require('oil').toggle_float('.')<CR>", {
      desc = 'Open parent directory',
      noremap = true,
      silent = true,
    })
    oil.setup {
      columns = {
        'icon',
        -- "permissions",
        'size',
        -- "mtime",
      },
      skip_confirm_for_simple_edits = true,
      lsp_file_methods = {
        enabled = true,
      },
      watch_for_changes = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
      git = {
        -- Return true to automatically git add/mv/rm files
        add = function(path)
          return true
        end,
        mv = function(src_path, dest_path)
          return false
        end,
        rm = function(path)
          return false
        end,
      },
    }
  end,
}
