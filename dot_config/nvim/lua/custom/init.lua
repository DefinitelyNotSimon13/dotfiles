vim.opt.colorcolumn = {"80", "120"}
vim.opt.scrolloff = 5
vim.g.copilot_no_tab_map = true
vim.opt.smartindent = true
vim.opt.conceallevel = 1
vim.opt.linebreak = true
vim.opt.list = false

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    vim.lsp.start({
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    })
  end,
})
