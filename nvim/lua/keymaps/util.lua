function Keymapn(key, desc, func)
  vim.keymap.set('n', key, function()
    return func()
  end, { desc = desc })
end

function Keymapi(key, desc, func)
  vim.keymap.set('i', key, function()
    return func()
  end, { desc = desc })
end
