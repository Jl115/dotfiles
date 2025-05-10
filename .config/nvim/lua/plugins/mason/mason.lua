return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    lazy = false,
    opts = {
      ensure_installed = {
        -- Linting/formatting
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "eslint-lsp",
        "prettierd",
        "rust-analyzer",
        "pyright",
        "ruff",
        "codelldb", -- if using rust-tools DAP
        "clangd",
        "clang-format",
        -- LSPs
        "typescript-language-server",
        "vue-language-server",
        "lua-language-server",
        "jdtls",
        "java-debug-adapter", -- from mason-nvim-dap
        "java-test",
        -- DAP
        "js-debug-adapter",
      },
    },
  },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
