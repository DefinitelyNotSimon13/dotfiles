vim.lsp.enable {
  'biome',
  'clangd',
  'cssls',
  'emmet_language_server',
  'emmet_ls',
  'eslint',
  'hls',
  'lua_ls',
  'nixd',
  'rust_analyzer',
  'tailwindcss',
  'tinymist',
  'ts_ls',
}

-- Autocommands

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end
    map('gh', '<CMD>ClangdSwitchSourceHeader<CR>', '[G]oto [H]eader/Source')

    map('gd', require('fzf-lua').lsp_definitions, '[G]oto [D]efinition')
    map('gD', require('fzf-lua').lsp_declarations, '[G]oto [D]eclaration')
    map('gr', require('fzf-lua').lsp_references, '[G]oto [R]eferences')
    map('gI', require('fzf-lua').lsp_implementations, '[G]oto [I]mplementation')
    map('<leader>D', require('fzf-lua').lsp_typedefs, 'Type [D]efinition')
    map('<leader>ds', require('fzf-lua').lsp_document_symbols, '[D]ocument [S]ymbols')
    map('<leader>ws', require('fzf-lua').lsp_live_workspace_symbols, '[W]orkspace [S]ymbols')
    map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('<leader>ca', require('fzf-lua').lsp_code_actions, '[C]ode [A]ction', { 'n', 'x' })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
        end,
      })
    end
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map('<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
      end, '[T]oggle Inlay [H]ints')
    end
  end,
})
