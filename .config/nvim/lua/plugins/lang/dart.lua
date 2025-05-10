return {
  -- 1. Flutter Tools: This plugin not only exposes Flutter commands (e.g. :FlutterRun, :FlutterReload)
  --    but also automatically sets up the Dart LSP for Flutter projects.
  {
    "Jl115/flutter-tools.nvim",
    lazy = false, -- set to false so it loads immediately; you can adjust lazy-loading as needed
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional, for improved UI in selections
    },
    config = function()
      require("flutter-tools").setup({
        -- Set your flutter executable path here if needed (or leave it as "flutter" if in your PATH)
        flutter_path = vim.fn.expand("$HOME") .. "/fvm/default/bin/flutter",
        -- If you use FVM (Flutter Version Management), set this to true
        fvm = true,
        -- LSP configuration for Dart:
        lsp = {
          -- The command to start the Dart language server
          cmd = { "dart", "language-server", "--protocol=lsp" },
          -- You can pass additional LSP settings here:
          settings = {
            dart = {
              completeFunctionCalls = true,
              -- When renaming files/classes, prompt or update imports automatically:
              renameFilesWithClasses = {
                prompt = true, -- or "prompt"
              }, -- or "always"
              enableSnippets = false,
              updateImportsOnRename = true,
              showTodos = true,
              inlineHints = {
                enabled = false, -- Disable inline hints
              },
            },
          },
          -- Optional: on_attach can be used to set keymaps when the server attaches
          -- on_attach = function(client, bufnr) ... end,
        },
        -- Optional decorations for your statusline, outline window etc.
        decorations = {
          statusline = {
            app_version = true,
            device = true,
            project_config = true,
          },
        },
      })
    end,
  },

  -- 2. (Optional) LSP configuration for dartls via nvim-lspconfig.
  --    Note: flutter-tools.nvim already sets up dartls, so if you use it you typically do not need this.
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       dartls = {
  --         cmd = { "dart", "language-server", "--protocol=lsp" },
  --         settings = {
  --           dart = {
  --             completeFunctionCalls = true,
  --             renameFilesWithClasses = "prompt",
  --             enableSnippets = true,
  --             updateImportsOnRename = true,
  --             showTodos = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },

  -- 3. Treesitter parser for Dart: Ensure proper syntax highlighting and folding.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "dart" })
    end,
  },

  -- 4. (Optional) Debug Adapter Protocol (DAP) for Flutter/Dart debugging.
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      dap.adapters.dart = {
        type = "executable",
        command = "flutter",
        args = { "debug_adapter" },
      }
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Dart Program",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },
}
