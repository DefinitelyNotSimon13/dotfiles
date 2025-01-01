return {
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function(_, opts)
      local crates = require 'crates'
      crates.setup(opts)
      crates.show()
    end,
  },
}
