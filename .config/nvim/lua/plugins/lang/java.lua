return {

  {
    "mfussenegger/nvim-dap",
    ft = "java",
    config = function()
      local dap = require("dap")

      -- Java adapter (must be provided)
      dap.adapters.java = function(callback)
        callback({
          type = "server",
          host = "127.0.0.1",
          port = 5005,
        })
      end

      dap.configurations.java = {
        {
          type = "java",
          request = "launch",
          name = "Launch Java Main",
          mainClass = function()
            return vim.fn.input("Main class > ")
          end,
          projectName = function()
            return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
          end,
        },
      }
    end,
  },
}
