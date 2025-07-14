function ToggleDiagnostics()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end

function ToggleDiagnosticsMode()
  local lines = vim.diagnostic.config().virtual_lines

  if lines then
    vim.diagnostic.config {
      virtual_lines = false,
      virtual_text = true,
    }
  else
    vim.diagnostic.config {
      virtual_lines = {
        current_line = true,
      },
      virtual_text = false,
    }
  end
end

function ToggleDiagnosticsHidden()
  local lines = vim.diagnostic.config().virtual_lines

  if lines then
    vim.diagnostic.config {
      virtual_lines = false,
      virtual_text = false,
    }
  else
    vim.diagnostic.config {
      virtual_lines = false,
      virtual_text = true,
    }
  end
end

vim.keymap.set('n', '<leader>td', '<cmd>lua ToggleDiagnostics()<cr>', { desc = '[T]oggle diagnostics [d]isabled' })
vim.keymap.set('n', '<leader>tm', '<cmd>lua ToggleDiagnosticsMode()<cr>', { desc = '[T]oggle diagnostics [m]ode' })
vim.keymap.set('n', '<leader>th', '<cmd>lua ToggleDiagnosticsModeHide()<cr>', { desc = '[T]oggle diagnostics [h]idden' })
