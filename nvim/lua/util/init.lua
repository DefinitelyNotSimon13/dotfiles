local Util = {}

function Util.termcodes(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function Util.clear_highlights()
  vim.cmd 'nohlsearch'
  if Util.lsp_active() then
    vim.lsp.buf.clear_references()
    for _, buffer in pairs(Util.visible_buffers()) do
      vim.lsp.util.buf_clear_references(buffer)
    end
  end
end

function Util.close_floats()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative == 'win' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

function Util.feedkeys(keys, mode)
  if mode == nil then
    mode = 'in'
  end
  return vim.api.nvim_feedkeys(Util.termcodes(keys), mode, true)
end

function Util.lsp_active()
  for _, client in pairs(vim.lsp.get_clients()) do
    if client.server_capabilities then
      return true
    end
  end
  return false
end

return Util
