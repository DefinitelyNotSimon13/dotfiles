return {
  'zk-org/zk-nvim',
  cond = not vim.g.vscode,
  config = function()
    require('zk').setup {}
  end,
}
