return {
  "saghen/blink.cmp",
  version = "*",

  -- OPTIONAL: If the freeze persists, force a rebuild by uncommenting this:
  build = "cargo build --release",

  event = "InsertEnter",
  dependencies = { "L3MON4D3/LuaSnip" },

  opts = function(_, opts)
    return {
      snippets = {
        preset = "luasnip",
      },
      appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        menu = {
          -- PERFORMANCE FIX: Disabling treesitter in the menu prevents
          -- freezes when scrolling through large lists.
          -- draw = { treesitter = { "lsp" } },
        },
        documentation = {
          auto_show = true,
          -- Increased delay slightly to prevent "flash freezes" while rapid typing
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = vim.g.ai_cmp },
      },
      sources = {
        default = { "snippets", "lsp", "path", "buffer" },
      },
      cmdline = {
        enabled = true,
      },
      keymap = {
        preset = "default",
        ["<CR>"] = { "fallback" },
        ["<Tab>"] = { "select_and_accept", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
      },
    }
  end,
}
