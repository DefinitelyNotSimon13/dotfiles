vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
})

local harpoon = require('harpoon')
local FzfLua = require('fzf-lua')

harpoon:setup()

local function toggle_fzf(harpoon_files)
  if harpoon_files._length <= 0 then
    vim.print('No files marked by harpoon')
    return
  end
  local entries_to_idx = {}

  FzfLua.fzf_exec(function(fzf_cb)
    entries_to_idx = {}
    for i = 1, harpoon_files._length do
      local item = harpoon_files.items[i]
      if item and item.value ~= '' then
        local entry = FzfLua.make_entry.file(item.value, { file_icons = true, color_icons = true })
        if not entry then
          return
        end
        entries_to_idx[item.value] = i
        fzf_cb(entry)
      end
    end
    fzf_cb()
  end, {
    file_icons = true,
    prompt = 'Harpoon> ',
    previewer = 'builtin',
    actions = {
      ['default'] = function(selected)
        if not selected or not selected[1] then
          return
        end
        vim.cmd.edit(vim.fn.fnameescape(selected[1]))
      end,
      ['ctrl-d'] = {
        fn = function(selected)
          if not selected or not selected[1] then
            return
          end
          local file = selected[1]:match('.-([%w%./_-].+)$')
          local idx = entries_to_idx[file]
          if not idx then
            vim.print('Unable to remove mark from ' .. selected[1])
            return
          end
          harpoon:list():remove_at(idx)
        end,
        reload = true,
      },
    },
  })
end

vim.keymap.set('n', '<C-e>', function()
  toggle_fzf(harpoon:list())
end, { desc = 'Open harpoon window' })

vim.keymap.set('n', '<leader>a', function()
  harpoon:list():add()
end, { desc = 'Harpoon [a]dd' })

vim.keymap.set('n', '<leader>hr', function()
  harpoon:list():remove()
end, { desc = '[H]arpoon [r]emove current file' })

for i = 1, 5 do
  vim.keymap.set('n', '<leader>' .. i, function()
    harpoon:list():select(i)
  end, { desc = 'Harpoon select [' .. i .. ']' })
end

vim.keymap.set('n', '<C-S-P>', function()
  harpoon:list():prev()
end, { desc = 'Harpoon previous' })

vim.keymap.set('n', '<C-S-N>', function()
  harpoon:list():next()
end, { desc = 'Harpoon next' })
