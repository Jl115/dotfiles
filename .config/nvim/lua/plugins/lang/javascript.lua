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
          return true -- verhindert doppelten tsserver-Start
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
