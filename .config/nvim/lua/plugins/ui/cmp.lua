return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "L3MON4D3/LuaSnip" },
    optional = true,
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = {
        { name = "luasnip", priority = 1000 },
        { name = "nvim_lsp", priority = 900 },
        { name = "path", priority = 800 },
        { name = "buffer", priority = 700 },
        { name = "emoji", priority = 600 },
        { name = "copilot", priority = 100 },
      }

      opts.sorting = {
        priority_weight = 3, -- Increased from 2 to 3
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.priority, -- Move priority up
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      }
    end,
  },
}
