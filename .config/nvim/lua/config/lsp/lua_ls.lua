---@type vim.lsp.Config
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_dir = require("lspconfig.util").root_pattern(
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git"
  ),
  single_file_support = false,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        -- Uncomment to disable specific diagnostics
        -- disable = { "missing-parameters", "missing-fields" },
      },
    },
  },
}
