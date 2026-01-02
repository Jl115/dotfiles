return {

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript and JavaScript Language Server
        ts_ls = {
          filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
        },

        -- Vue Language Server
        vue_ls = {
          filetypes = { "vue" },
          init_options = {
            vue = { hybridMode = false },
            typescript = {
              tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            },
          },
          on_attach = function(client)
            -- Disable diagnostics from Volar to prevent duplicates
            client.handlers["textDocument/publishDiagnostics"] = function() end
          end,
        },

        -- SonarLint (Corrected & Robust + High Visibility)
        sonarlint = {
          filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue" },
          init_options = {
            showVerboseLogs = true,
          },
          cmd = {
            "sonarlint-language-server",
            "-stdio",
            "-analyzers",
            vim.fn.expand(
              vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/analyzers/sonarjs.jar"
            ),
          },
          root_dir = function(fname)
            return require("lspconfig").util.root_pattern("package.json", ".git")(fname)
          end,
          -- NEW: This handler boosts "Info" and "Hint" messages to "Warning"
          handlers = {
            ["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
              if result and result.diagnostics then
                for _, d in ipairs(result.diagnostics) do
                  -- Severity 3 is Info, 4 is Hint. We change them to 2 (Warning).
                  if d.severity and d.severity > 2 then
                    d.severity = 2
                  end
                end
              end
              vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
            end,
          },
          settings = {
            sonarlint = {
              rules = {
                -- Example: ["typescript:S101"] = { level = "off" },
              },
            },
          },
        },
      },
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
        log_file_level = os.getenv("DEBUG") and 1 or 2,
        log_console_level = os.getenv("DEBUG") and 1 or 2,
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
