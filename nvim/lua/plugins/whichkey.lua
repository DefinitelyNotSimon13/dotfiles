return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    icons = { mappings = vim.g.have_nerd_font },

    spec = {
      { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
      { '<leader>C', group = '[C]omplete' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
    },
  },
}
