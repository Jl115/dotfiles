---@type vim.lsp.Config
return (function()
  local cwd = vim.fn.getcwd()
  local local_ts = cwd .. "/node_modules/typescript/lib"
  local global_ts = vim.fn.trim(vim.fn.system("npm root -g")) .. "/typescript/lib"
  local mason_ts = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"

  local tsdk = vim.fn.isdirectory(local_ts) == 1 and local_ts
    or (vim.fn.isdirectory(global_ts) == 1 and global_ts)
    or mason_ts

  return {
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
    single_file_support = false,
    log_level = vim.lsp.protocol.MessageType.Warning,
    init_options = {
      typescript = { tsdk = tsdk },
    },
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "none",
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  }
end)()
