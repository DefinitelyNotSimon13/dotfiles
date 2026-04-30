vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'Cargo.toml',
  once = true,
  callback = function()
    vim.pack.add({ 'https://github.com/saecki/crates.nvim' })
    local crates = require('crates')
    crates.setup()
    crates.show()
  end,
})
