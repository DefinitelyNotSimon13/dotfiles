return {
  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),

        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      require('CopilotChat.integrations.cmp').setup()

      cmp.setup {
        view = {
          entries = {
            follow_cursor = true,
          },
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},
          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'crates', group_index = 2 },
          { name = 'nvim_lsp', group_index = 2 },
          { name = 'luasnip', group_index = 2 },
          { name = 'path', group_index = 2 },
          { name = 'buffer', group_index = 2 },
        },
      }

      --[[
  Get completion context, such as namespace where item is from.
  Depending on the LSP, this information is stored in different places.
  The process to find them is very manual: log the payloads And see where useful information is stored.

  See https://www.reddit.com/r/neovim/comments/128ndxk/comment/jen9444/?utm_source=share&utm_medium=web2x&context=3
]]
      local function get_lsp_completion_context(completion, source)
        local ok, source_name = pcall(function()
          return source.source.client.config.name
        end)
        if not ok then
          return nil
        end

        if source_name == 'tsserver' then
          return completion.detail
        elseif source_name == 'pyright' and completion.labelDetails ~= nil then
          return completion.labelDetails.description
        elseif source_name == 'texlab' then
          return completion.detail
        elseif source_name == 'clangd' then
          local doc = completion.documentation
          if doc == nil then
            return
          end

          local import_str = doc.value

          local i, j = string.find(import_str, '["<].*[">]')
          if i == nil then
            return
          end

          return string.sub(import_str, i, j)
        end
      end

      format = function(entry, vim_item)
        if not require('cmp.utils.api').is_cmdline_mode() then
          local abbr_width_max = 25
          local menu_width_max = 20

          local choice = require('lspkind').cmp_format {
            ellipsis_char = tools.ui.icons.ellipses,
            maxwidth = abbr_width_max,
            mode = 'symbol',
          }(entry, vim_item)

          choice.abbr = vim.trim(choice.abbr)

          -- give padding until min/max width is met
          -- https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499
          local abbr_width = string.len(choice.abbr)
          if abbr_width < abbr_width_max then
            local padding = string.rep(' ', abbr_width_max - abbr_width)
            vim_item.abbr = choice.abbr .. padding
          end

          local cmp_ctx = get_lsp_completion_context(entry.completion_item, entry.source)
          if cmp_ctx ~= nil and cmp_ctx ~= '' then
            choice.menu = cmp_ctx
          else
            choice.menu = ''
          end

          local menu_width = string.len(choice.menu)
          if menu_width > menu_width_max then
            choice.menu = vim.fn.strcharpart(choice.menu, 0, menu_width_max - 1)
            choice.menu = choice.menu .. tools.ui.icons.ellipses
          else
            local padding = string.rep(' ', menu_width_max - menu_width)
            choice.menu = padding .. choice.menu
          end

          return choice
        else
          local abbr_width_min = 20
          local abbr_width_max = 50

          local choice = require('lspkind').cmp_format {
            ellipsis_char = tools.ui.icons.ellipses,
            maxwidth = abbr_width_max,
            mode = 'symbol',
          }(entry, vim_item)

          choice.abbr = vim.trim(choice.abbr)

          -- give padding until min/max width is met
          -- https://github.com/hrsh7th/nvim-cmp/issues/980#issuecomment-1121773499
          local abbr_width = string.len(choice.abbr)
          if abbr_width < abbr_width_min then
            local padding = string.rep(' ', abbr_width_min - abbr_width)
            vim_item.abbr = choice.abbr .. padding
          end

          return choice
        end
      end
    end,
  },
  {},
}
