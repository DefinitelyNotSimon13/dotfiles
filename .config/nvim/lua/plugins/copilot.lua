M = {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }

      vim.keymap.set('n', '<leader>cd', '<Cmd>Copilot disable<CR>', { desc = '[C]opilot [d]isable' })
      vim.keymap.set('n', '<leader>ce', '<Cmd>Copilot enable<CR>', { desc = '[C]opilot [e]nable' })
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    event = 'VeryLazy',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' },  -- for curl, log wrapper
      { 'nvim-telescope/telescope.nvim' },
    },
    opts = {
      debug = false, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
    keys = {
      {
        '<leader>ccq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Show help actions with telescope
      {
        '<leader>cch',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ccp',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - Prompt actions',
      },
      {
        '<leader>ctf',
        function()
          toggle_floating_window()
        end,
        desc = '[C]opilot [t]oggle [f]loating Window',
      },
    },
  },
}

function toggle_floating_window()
  local floating_window = {
    window = {
      layout = 'float',
      relative = 'cursor',
      width = 1,
      height = 0.4,
      row = 1,
    },
  }
  local no_floating_window = {
    window = {
      layout = 'vertical',    -- 'vertical', 'horizontal', 'float', 'replace'
      width = 0.5,            -- fractional width of parent, or absolute width in columns when > 1
      height = 0.5,           -- fractional height of parent, or absolute height in rows when > 1
      -- Options below only apply to floating windows
      relative = 'editor',    -- 'editor', 'win', 'cursor', 'mouse'
      border = 'single',      -- 'none', single', 'double', 'rounded', 'solid', 'shadow'
      row = nil,              -- row position of the window, default is centered
      col = nil,              -- column position of the window, default is centered
      title = 'Copilot Chat', -- title of chat window
      footer = nil,           -- footer of chat window
      zindex = 1,             -- determines if window is on top or below other floating windows
    },
  }
  local copilot_chat = require 'CopilotChat'
  local current_opts = copilot_chat.config

  if current_opts.window.layout == 'float' then
    for k, v in pairs(no_floating_window) do
      current_opts[k] = v
    end
  else
    for k, v in pairs(floating_window) do
      current_opts[k] = v
    end
  end

  copilot_chat.setup(current_opts)
end

return M
