vim.pack.add({ 'https://github.com/stevearc/oil.nvim' })

local oil = require('oil')

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
vim.keymap.set('n', '<leader>-', "<CMD>lua require('oil').toggle_float('.')<CR>", {
  desc = 'Open parent directory (float)',
  noremap = true,
  silent = true,
})

oil.setup({
  default_file_explorer = true,
  columns = {
    'icon',
    'size',
  },
  skip_confirm_for_simple_edits = true,
  lsp_file_methods = {
    enabled = true,
  },
  watch_for_changes = true,
  view_options = {
    show_hidden = true,
  },
  git = {
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
})
