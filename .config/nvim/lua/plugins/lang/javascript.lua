return {

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      "pmizio/typescript-tools.nvim",
    },
    opts = {
      servers = {
        tsserver = {},
        volar = {
          filetypes = {
            "vue",
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
          },
        },
      },
      setup = {
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })

          local util = require("lspconfig.util")
          opts.root_dir = function(fname)
            local js_root = util.search_ancestors(fname, function(dir)
              return vim.fn.filereadable(dir .. "/jsconfig.json") == 1 and dir or nil
            end)
            return js_root or util.root_pattern("package.json", "tsconfig.json", ".git")(fname)
          end
        end,

        volar = function(_, opts)
          local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
          local global_ts = vim.fn.trim(vim.fn.system("npm root -g")) .. "/typescript/lib"

          local tsdk = vim.fn.isdirectory(local_ts) == 1 and local_ts
            or (vim.fn.isdirectory(global_ts) == 1 and global_ts)
            or (vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib")

          opts.init_options = {
            typescript = { tsdk = tsdk },
          }

          opts.settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "none",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = false,
              },
            },
          }
        end,
      },
      on_attach = function(client, buffer)
        if client.name == "tsserver" then
          vim.keymap.set("n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { buffer = buffer, desc = "Rename File" })
        end
      end,
    },
  },

  -- DAP
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dap_vscode_js = require("dap-vscode-js")

      dap_vscode_js.setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        adapters = {
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
        },
        debugger_cmd = { "js-debug-adapter" },
        log_file_path = vim.fn.stdpath("cache") .. "/dap-vscode-js.log",
        log_file_level = os.getenv("DEBUG") and 1 or 2, -- DEBUG or INFO
        log_console_level = os.getenv("DEBUG") and 1 or 2, -- DEBUG or INFO
      })

      for _, language in ipairs({ "typescript", "javascript", "vue" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
