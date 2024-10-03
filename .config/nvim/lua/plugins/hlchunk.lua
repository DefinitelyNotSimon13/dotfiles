return {
  'shellRaining/hlchunk.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('hlchunk').setup {
      blank = {
        enable = true,
        chars = {
          ' ',
        },
        style = {
          { bg = '#434437' },
          { bg = '#2f4440' },
          { bg = '#433054' },
          { bg = '#284251' },
        },
      },
      chunk = {
        enable = true,
        style = {
          { fg = '#89dceb' },
          { fg = '#fab387' },
        },
        textobject = 'ic',
        duration = 100,
        delay = 150,
      },
      indent = {
        enable = true,
        use_treesitter = true,
        chars = {
          '│',
          '¦',
        },
      },
      line_num = {
        enable = true,
      },
    }
  end,
}
