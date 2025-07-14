local vscode = require 'vscode'

Keymapn('<leader>sf', '', function()
  vscode.call 'workbench.action.quickOpen'
end)
