vim.keymap.set('n', '<leader>p', ':TypstPreview<CR>', { buffer = 0 })

vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.whichwrap:append 'h,l,<,>,[,],~'
