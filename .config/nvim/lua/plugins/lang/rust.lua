return {
  --LSP

  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")
      dap.adapters.lldb = {
        type = "executable",
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode", -- adjust as needed
        name = "lldb",
      }
      dap.configurations.rust = {
        {
          name = "Launch Rust",
          type = "lldb",
          request = "launch",
          program = function()
            return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }
    end,
  },
}
