return {
  {

    'rust-lang/rust.vim',
    ft = 'rust',
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
  {
    {
      'mrcjkb/rustaceanvim',
      version = '^4', -- Recommended
      ft = { 'rust' },
      config = function()
        local bufnr = vim.api.nvim_get_current_buf()
        vim.keymap.set('n', '<leader>cr', function()
          vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
          -- or vim.lsp.buf.codeAction() if you don't want grouping.
        end, { silent = true, buffer = bufnr, desc = '[C]ode action [r]ust' })
        vim.g.rustaceanvim = {
          -- Plugin configuration
          tools = {},
          -- LSP configuration
          server = {
            on_attach = function(client)
              if client.server_capabilities.inlayHintProvider then
                local bufnr = vim.api.nvim_get_current_buf()
                vim.lsp.inlay_hint.enable(bufnr, true)
              end
            end,
            default_settings = {
              -- rust-analyzer language server configuration
              ['rust-analyzer'] = {},
            },
          },
          -- DAP configuration
          dap = {},
        }
      end,
    },
  },
  {
    'saecki/crates.nvim',
    ft = { 'rust', 'toml' },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)
    end,
  },
}
