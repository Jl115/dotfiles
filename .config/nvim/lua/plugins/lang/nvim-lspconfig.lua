return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  lazy = "VeryLazy", -- Load this plugin only when needed
  config = function(self, opts)
    -- This on_attach function is a default that will be used for any server
    -- that doesn't define its own custom on_attach.
    local on_attach = function(client, bufnr)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufr, noremap = true, silent = true, desc = "LSP: " .. desc })
      end

      -- Map directly to the Lua function, not a command string
      map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
      map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
      map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
      map("n", "gr", vim.lsp.buf.references, "Go to References")
      map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
      map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      map("n", "<leader>f", vim.lsp.buf.format, "Format Document") -- Use .format for modern Neovim
    end

    -- Get the server-specific setup functions from our opts table
    local setup_handlers = (opts and opts.setup) or {}

    -- Get server configurations
    local servers = (opts and opts.servers) or {}

    -- Set up mason-lspconfig to bridge Mason with lspconfig
    require("mason-lspconfig").setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    -- The core logic: loop through all servers and set them up.
    for server_name, server_opts in pairs(servers) do
      -- Check if there's a custom setup function for this server.
      if setup_handlers[server_name] then
        -- If the custom setup function returns `true`, it means it handled everything
        -- and we should skip the default lspconfig setup.
        if setup_handlers[server_name](self, server_opts) then
          goto continue_loop
        end
      end

      -- If no custom handler, or if it returned false, perform the default setup.
      require("lspconfig")[server_name].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach, -- Use our default on_attach
        -- You can add default capabilities here if you use nvim-cmp
        -- capabilities = require("cmp_nvim_lsp").default_capabilities(),
      }, server_opts))

      ::continue_loop::
    end
    local function gmap(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = "Diagnostic: " .. desc })
    end

    gmap("n", "<leader>df", vim.diagnostic.open_float, "Show Diagnostics")
    gmap("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic") -- Using [d and ]d is a common convention
    gmap("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
    gmap("n", "<leader>q", vim.diagnostic.setloclist, "Quickfix Diagnostics")
  end,
}
