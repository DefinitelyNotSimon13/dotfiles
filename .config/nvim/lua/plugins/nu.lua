return {
  'lhKipp/nvim-nu',
  ft = { 'nu' },
  config = function()
    require('nu').setup {}
  end,
}
