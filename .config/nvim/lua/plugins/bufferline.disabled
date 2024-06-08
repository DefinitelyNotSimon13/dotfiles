return {
  'akinsho/bufferline.nvim',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require 'bufferline'
    bufferline.setup {
      options = {
        style_preset = bufferline.style_preset.no_italic,
        numbers = 'ordinal',
        diagnostics = 'nvim_lsp',
        diagnostics_update_in_insert = true,
        separator_style = 'slant',
        always_show_bufferline = false,
        indicator = {
          style = 'underline',
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    }
  end,
}
