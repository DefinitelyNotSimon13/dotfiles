vim.pack.add {
  'https://github.com/onsails/lspkind.nvim',
  { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range '*' },
}

require('blink.cmp').setup {
  keymap = { preset = 'default' },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    menu = {
      draw = {
        components = {
          kind_icon = {
            text = function(item)
              local kind = require('lspkind').symbol_map[item.kind] or ''
              return kind .. ' '
            end,
            highlight = 'CmpItemKind',
          },
        },
      },
    },
  },

  snippets = { preset = 'luasnip' },

  fuzzy = { implementation = 'lua' },

  signature = {
    enabled = true,
    window = { border = 'rounded' },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
}
