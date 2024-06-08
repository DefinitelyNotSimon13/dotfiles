return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('refactoring').setup {
      printf_statements = {
        -- add a custom printf statement for cpp
        cpp = {
          'std::cout << "%s" << std::endl;',
        },
      },
    }
    vim.keymap.set('x', '<leader>re', ':Refactor extract ', { desc = '[R]efactor [e]xtract' })
    vim.keymap.set('x', '<leader>rf', ':Refactor extract_to_file ', { desc = '[R]efactor extract to [f]ile' })

    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = '[R]efactor extract [v]ariable' })

    vim.keymap.set({ 'n', 'x' }, '<leader>ri', ':Refactor inline_var', { desc = '[R]efactor [i]nline variable' })

    vim.keymap.set('n', '<leader>rI', ':Refactor inline_func', { desc = '[R]efactor [I]nline function' })

    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block', { desc = '[R]efactor extract [b]lock' })
    vim.keymap.set('n', '<leader>rbf', ':Refactor extract_block_to_file', { desc = '[R]efactor extract [b]lock to [f]ile' })
    vim.keymap.set({ 'n', 'x' }, '<leader>rr', function()
      require('refactoring').select_refactor()
    end, { desc = '[R]efacto[r]' })
  end,
}
