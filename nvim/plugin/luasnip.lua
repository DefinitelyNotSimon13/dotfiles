vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'LuaSnip' and ev.data.kind == 'install' then
      if vim.fn.has('win32') == 0 and vim.fn.executable('make') == 1 then
        vim.fn.system({ 'make', 'install_jsregexp' })
      end
    end
  end,
})

vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/L3MON4D3/LuaSnip',
})

require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').setup()
