return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "basic", -- or "strict"
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      },
      ruff = {
        -- Requires ruff >= 0.1.0 installed globally (pip install ruff)
        -- No special config needed unless using custom args
        settings = {
          args = {}, -- optional
        },
      },
    },
  },
}
