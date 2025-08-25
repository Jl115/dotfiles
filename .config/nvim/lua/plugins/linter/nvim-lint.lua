return {
  "mfussenegger/nvim-lint",
  opts = {
    -- check linters on 'https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file'
    linters_by_ft = {
      javascript = { "eslint_d" },
      -- lua = { "luac" },
      typescript = { "eslint_d" },
      -- java = { "sonarlint-language-server" },
      vue = { "eslint_d" },
    },
  },
}
