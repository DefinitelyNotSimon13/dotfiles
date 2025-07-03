require 'keymaps.default'
require 'keymaps.util'

if not vim.g.vscode then
  require 'keymaps.extended'
else
  require 'keymaps.code'
end
