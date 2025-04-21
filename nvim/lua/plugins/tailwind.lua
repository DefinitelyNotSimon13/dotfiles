return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'neovim/nvim-lspconfig',
  },
  opts = {
    server = {
      settings = {
        experimental = {
          classRegex = { 'class\\s*:\\s*"([^"]*)' },
        },
      },
    },
    extension = {
      rust = { 'class: "(.*)"' },
    },
  },
}
