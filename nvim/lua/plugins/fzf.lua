return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  cond = not vim.g.vscode,
  opts = function()
    local fzf = require 'fzf-lua'

    fzf.register_ui_select()

    vim.keymap.set('n', '<leader>G', fzf.global, { desc = 'Search [G]obal' })
    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sm', fzf.manpages, { desc = '[S]earch [M]anpages' })
    vim.keymap.set('n', '<leader>sC', fzf.commands, { desc = '[S]earch [C]ommands' })
    vim.keymap.set('n', '<leader>sc', fzf.command_history, { desc = '[S]earch [C]ommand History' })
    vim.keymap.set('n', '<leader>ssc', fzf.spellcheck, { desc = '[S]earch [S]pell [C]heck' })
    vim.keymap.set('n', '<leader>sss', fzf.spell_suggest, { desc = '[S]earch [S]pell [S]uggestions' })
    vim.keymap.set('n', '<leader>sp', fzf.packadd, { desc = '[S]earch [P]ack [A]dd' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sS', fzf.builtin, { desc = '[S]earch [S]elect fzf' })
    vim.keymap.set({ 'n', 'v' }, '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep_native, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sG', fzf.grep_last, { desc = '[S]earch by [G]rep with last pattern' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>z', fzf.zoxide, { desc = '[S]earch [Z]oxide' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers' })

    local fzf_complete = {
      p = { fn = fzf.complete_path, desc = 'Complete [P]ath' },
      f = { fn = fzf.complete_file, desc = 'Complete [F]ile' },
      l = { fn = fzf.complete_line, desc = 'Complete [L]ine' },
      b = { fn = fzf.complete_bline, desc = 'Complete [B]uffer Line' },
    }

    local function with_complete_prefix(desc)
      return desc:gsub('^Complete', '[C]omplete')
    end

    for key, item in pairs(fzf_complete) do
      vim.keymap.set({ 'n', 'i', 'v' }, '<C-X>' .. key, item.fn, { silent = true, desc = item.desc })
      vim.keymap.set('n', '<leader>C' .. key, item.fn, { desc = with_complete_prefix(item.desc) })
    end

    vim.keymap.set('n', '<leader>/', function()
      fzf.lgrep_curbuf { previewer = false }
    end, { desc = '[/] Search in current buffer' })
    vim.keymap.set('n', '<leader>sn', function()
      fzf.files {
        cwd = vim.fn.stdpath 'config',
      }
    end, { desc = '[S]earch [N]eovim files' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('fzf-lsp-attach', { clear = true }),
      callback = function(event)
        vim.keymap.set('n', '<leader>g', fzf.lsp_finder, { buffer = event.buf, desc = 'All LSP locations' })
        vim.keymap.set('n', 'gr', fzf.lsp_references, { buffer = event.buf, desc = '[G]oto [R]eferences' })
        vim.keymap.set('n', 'gi', fzf.lsp_implementations, { buffer = event.buf, desc = '[G]oto [I]mplementations' })
        vim.keymap.set('n', 'gd', fzf.lsp_definitions, { buffer = event.buf, desc = '[G]oto [D]efinitions' })
        vim.keymap.set('n', 'gt', fzf.lsp_typedefs, { buffer = event.buf, desc = '[G]oto [T]ype Definition' })
        vim.keymap.set('n', 'gO', fzf.lsp_document_symbols, { buffer = event.buf, desc = 'Open Document Symbols' })
        vim.keymap.set('n', 'gW', fzf.lsp_live_workspace_symbols, { buffer = event.buf, desc = 'Open Workspace Symbols' })
        vim.keymap.set('n', '<C-O>d', fzf.lsp_document_diagnostics, { buffer = event.buf, desc = 'Open Document Diagnostics' })
        vim.keymap.set('n', '<C-O>D', fzf.lsp_document_diagnostics, { buffer = event.buf, desc = 'Open Workspace Diagnostics' })

        vim.keymap.set({ 'n', 'x' }, '<leader>ca', fzf.lsp_code_actions, { buffer = event.buf, desc = '[C]ode [Actions]' })
      end,
    })
  end,
}
