return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 1. Configure ts_ls with the Vue Plugin
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                -- Point to the Mason installation of vue-language-server
                location = vim.fn.stdpath("data")
                  .. "/mason/packages/vue-language-server/node_modules/@vue/language-server",
                languages = { "vue" },
              },
            },
            preferences = {
              disableSuggestions = true,
            },
          },
          -- Ensure it attaches to Vue files
          filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
        },

        -- 2. Configure vue_ls (Volar)
        vue_ls = {
          filetypes = { "vue" },
          init_options = {
            vue = { hybridMode = false },
            typescript = {
              -- Point to the Mason installation of TypeScript
              tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
            },
          },
        },
      },
      setup = {},
    },
  },

  -- DAP Configuration (Unchanged)
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap = require("dap")
      local dap_vscode_js = require("dap-vscode-js")

      dap_vscode_js.setup({
        node_path = "node",
        debugger_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
        debugger_cmd = { "js-debug-adapter" },
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
        }
      end
    end,
  },
}
