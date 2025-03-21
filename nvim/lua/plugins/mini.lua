vim.cmd [[
augroup MiniStarterSettings
    autocmd!
    autocmd FileType starter setlocal colorcolumn=0
augroup END
]]

return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.basics').setup()
    require('mini.icons').setup()
    require('mini.surround').setup()
    require('mini.starter').setup()
    require('mini.comment').setup()
    require('mini.pairs').setup()
    require('mini.diff').setup()
    require('mini.extra').setup()
    require('mini.git').setup()

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    ---@diagnostic disable-next-line: duplicate-set-field

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
