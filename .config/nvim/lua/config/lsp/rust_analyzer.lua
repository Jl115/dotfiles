---@type vim.lsp.Config
return {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = require("lspconfig.util").root_pattern("Cargo.toml", ".git"),
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
}
