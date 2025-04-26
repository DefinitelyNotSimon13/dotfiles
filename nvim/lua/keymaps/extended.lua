local Util = require 'util'

-- Close floats, and clear highlights with <Esc>
vim.keymap.set('n', '<Esc>', function()
  -- not really needed??
  Util.close_floats()
  if vim.bo.modifiable then
    Util.clear_highlights()
  end
  if #vim.api.nvim_list_wins() > 1 then
    return Util.feedkeys '<C-w>c'
  end
end, { desc = 'Close floats, clear highlights' })
