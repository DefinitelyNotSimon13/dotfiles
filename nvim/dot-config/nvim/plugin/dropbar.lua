vim.pack.add({ 'https://github.com/Bekaboo/dropbar.nvim' })

-- Dracula doesn't define WinBar, so dropbar renders black
local function set_winbar_hl()
  vim.api.nvim_set_hl(0, 'WinBar',   { bg = '#282a36', fg = '#f8f8f2' })
  vim.api.nvim_set_hl(0, 'WinBarNC', { bg = '#282a36', fg = '#6272a4' })
end

set_winbar_hl()
vim.api.nvim_create_autocmd('ColorScheme', { pattern = 'dracula', callback = set_winbar_hl })
