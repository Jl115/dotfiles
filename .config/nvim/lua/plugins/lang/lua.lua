return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim", "require" },
              disable = { "missing-fields" },
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
                "${3rd}/luv/library",
                "${3rd}/busted/library",
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = "space",
                indent_size = "2",
              },
            },
          },
        },
      },
    },
  },
}
