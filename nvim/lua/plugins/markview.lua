return {
  'OXY2DEV/markview.nvim',
  lazy = false, -- Recommended
  -- ft = "markdown" -- If you decide to lazy-load anyway

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local presets = require 'markview.presets'
    require('markview').setup {
      checkboxes = presets.checkboxes.nerd,
      headings = presets.headings.glow,
      horizontal_rules = presets.horizontal_rules.thick,
      -- configuration = {
      --   highlight_groups = 'dynamic',
      -- },
    }
    require('markview.extras.headings').setup()
    require('markview.extras.checkboxes').setup {
      --- When true, list item markers will
      --- be removed.
      remove_markers = true,

      --- If false, running the command on
      --- visual mode doesn't change the
      --- mode.
      exit = true,

      default_marker = '-',
      default_state = 'X',

      --- A list of states
      states = {
        { ' ', 'X' },
        { '-', 'o', '~' },
      },
    }
    require('markview.extras.editor').setup {
      --- The minimum & maximum window width
      --- If the value is smaller than 1 then
      --- it is used as a % value.
      ---@type [ number, number ]
      width = { 10, 0.75 },

      --- The minimum & maximum window height
      ---@type [ number, number ]
      height = { 3, 0.75 },

      --- Delay(in ms) for window resizing
      --- when typing.
      ---@type integer
      debounce = 50,

      --- Callback function to run on
      --- the floating window.
      ---@type fun(buf:integer, win:integer): nil
      callback = function(buf, win) end,
    }
  end,
}
