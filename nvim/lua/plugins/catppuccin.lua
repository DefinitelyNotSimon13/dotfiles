return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  cond = true,
  init = function()
    require('catppuccin').setup {
      transparent_background = true,
    }
  end,
}
