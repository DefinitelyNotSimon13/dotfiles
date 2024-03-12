local M = {}
M.insert = {
  i = {
    ["jj"] = {
      "<esc>",
      "Escape"
    }
  }
}
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>di"] = {
      "<cmd> DaptStepInto <CR>",
      "Step Into",
    },
    ["<leader>do"] = {
      "<cmd> DapStepOver <CR>",
      "Step Over",
    },
    ["<leader>dO"] = {
      "<cmd> DapStepOut <CR>",
      "Step Out",
    },
  }
}

M.clangformat = {
  plugin = true,
  n = {
    ["<leader>cf"] = {
      "<cmd> ClangFormat <CR>",
      "Format file using clang formatter",
    }
  }
}

M.cmaketools = {
  plugin = true,
  n = {
    ["<leader>cb"] = {
      "<cmd> CMakeBuild <CR>",
      "Build a project using CMake"
    },
    ["<leader>cr"] = {
      "<cmd> CMakeRun <CR>",
      "Run a project using CMakeTools"
    }
  }
}

M.lazygit = {
  plugin = true,
  n = {
    ["<leader>lg"] = {
      "<cmd> LazyGit <CR>",
      "Open LazyGit"
    }
  }
}

M.copilot = {
  plugin = true,
  n = {
    ["<leader>ce"] = {
      "<cmd> Copilot enable <CR>",
      "Enable Copilot inline suggestions"
    },
    ["<leader>cd"] = {
      "<cmd> Copilot disable <CR>",
      "Disable Copilot inline suggestions"
    },
    ["<leader>cp"] = {
      "<CMD> Copilot panel <CR>",
      "Open a panel with up to 10 completions"
    },
    ["<leader>cg"] = {
      "<silent><script><expr>copilot#Accept<CR>",
      "Accept a Copilot expression"
    },
  },
}

M.vimTmuxNavigator = {
  plugin = true,
  n = {
    ["<C-h>"] = {
      "<cmd>TmuxNavigateLeft<CR>",
      "Navigate Tmux"
    },
    ["<C-j>"] = {
      "<cmd>TmuxNavigateDown<CR>",
      "Navigate Tmux"
    },
    ["<C-k>"] = {
      "<cmd>TmuxNavigateUp<CR>",
      "Navigate Tmux"
    },
    ["<C-l>"] = {
      "<cmd>TmuxNavigateRight<CR>",
      "Navigate Tmux"
    },
  }
}

M.obsidian = {
  n = {
    ["<leader>oo"] = {
      "<cmd>ObsidianOpen<CR>",
      "Open the current file in Obsidian"
    },
    ["<leader>oc"] = {
      "<cmd>ObsidianCheck<CR>",
      "Run Obsidian Check"
    },
    ["<leader>of"] = {
      "<cmd>ObsidianFollowLink<CR>",
      "Follow the currently selected Link"
    },
    ["<leader>on"] = {
      "<cmd>ObsidianNew<CR>",
      "Create a new file"
    },
    ["<leader>oq"] = {
      "<cmd>ObsidianQuickSwitch<CR>",
      "Quickly switch between Obsidian files"
    },
    ["<leader>od"] = {
      "<cmd>ObsidianToday<CR>",
      "Open today's note"
    }
  }
}

M.shfmt = {
  n = {
    ["<leader>sf"] = {
      "<cmd>Shfmt<CR>",
      "Format sh file"
    }
  }
}
M.shellcheck = {
  n = {
    ["<leader>scr"] = {
      "<cmd>ShellCheck<CR>",
      "Run ShellCheck"
    },
    ["<leader>scb"] = {
      "<cmd>ShellCheck!<CR>",
      "Run ShellCheck with a Bang!"
    },
    ["<leader>scl"] = {
      "<cmd>LShellCheck!<CR>",
      "Run ShellCheck with a Bang and send errors to a location-list-window"
    },
  }
}
return M
