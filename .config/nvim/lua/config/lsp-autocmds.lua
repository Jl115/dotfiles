vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    local bufnr = args.buf
    if not client then
      return
    end

    -- Keymaps for tsserver/vtsls
    if client.name == "tsserver" or client.name == "vtsls" then
      vim.keymap.set("n", "<leader>co", "<cmd>OrganizeImports<CR>", { buffer = bufnr, desc = "Organize Imports" })
      vim.keymap.set("n", "<leader>cR", "<cmd>RenameFile<CR>", { buffer = bufnr, desc = "Rename File" })
    end

    -- Optional: file watcher if supported
    if client.server_capabilities.didChangeWatchedFiles then
      local watcher = vim.lsp.util.workspace_file_watcher("**/*")
      watcher.on_change(function(path, change_type)
        vim.schedule(function()
          vim.notify("File changed: " .. path .. " [" .. change_type .. "]", vim.log.levels.DEBUG)
        end)
      end)
    end

    -- Optional: custom diagnostic visuals
    -- vim.diagnostic.config({
    --   virtual_lines = true,
    --   virtual_text = false,
    -- })
  end,
})
