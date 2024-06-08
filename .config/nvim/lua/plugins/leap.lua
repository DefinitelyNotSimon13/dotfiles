return {
  'ggandor/leap.nvim',
  dependencies = { 'tpope/vim-repeat' },
  config = function()
    vim.keymap.set({ 'n', 'x', 'o' }, 'ss', '<Plug>(leap-forward)', { desc = 'Leap forward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'sS', '<Plug>(leap-backward)', { desc = 'Leap backward' })
    vim.keymap.set({ 'n', 'x', 'o' }, 'gs', '<Plug>(leap-from-window)', { desc = 'Leap from window' })
  end,
}
