return {
  {
    "mason-org/mason.nvim",
    version = "^1.0.0",
    lazy = false,
    opts = {
      ensure_installed = {
        -- Linting/Formatting
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "prettierd",
        "ruff",
        "clang-format",
        -- LSPs
        "lua-language-server",
        "vtsls", -- replaces typescript-language-server
        "vue-language-server",
        "eslint-lsp",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "rust-analyzer",
        "pyright",
        "jdtls",
        "marksman",
        "clangd",

        -- Debugging / DAP
        "codelldb",
        "js-debug-adapter",
        "java-debug-adapter",
        "java-test",
      },
    },
  },
}
