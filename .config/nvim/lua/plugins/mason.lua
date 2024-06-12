return {
  {
    'williamboman/mason.nvim',
    cmd = { 'Mason', 'MasonInstall', 'MasonUpdate' },
    config = function(_, opts)
      require('mason').setup(opts)
    end,
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        'lua-language-server',
        'rust-analyzer',
        'rustfmt',
        'stylua',
      },
    },
    dependencies = { 'williamboman/mason.nvim' },
    cmd = {
      'MasonToolsInstall',
      'MasonToolsInstallSync',
      'MasonToolsUpdate',
      'MasonToolsUpdateSync',
      'MasonToolsClean',
    },
  },
}
