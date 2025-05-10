return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Not strictly required, but recommended
  },

  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        group_empty_dirs = true,
        auto_expand_single_child = true,
        auto_collapse = true,
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      hijack_netrw_behavior = "open_default",
      use_libuv_file_watcher = true, -- Enables live updates
      cwd_target = {
        sidebar = "tab", -- use cwd of current tab (not the global one)
        current = "window", -- cwd updates with buffer's window
      },
    },
    source_selector = {
      winbar = true,
      statusline = true,
    },
    window = {
      position = "left", -- instead of "right"
      close_on_open = true,
      width = 60,
    },

    popup_border_style = "rounded",
    event_handlers = {
      -- {
      --   event = "after_render",
      --   handler = function()
      --     local state = require("neo-tree.sources.manager").get_state("filesystem")
      --     if not require("neo-tree.sources.common.preview").is_active() then
      --       state.config = { use_float = false, use_image_nvim = true, title = "Neo-tree Preview" }
      --       state.commands.toggle_preview(state)
      --     end
      --   end,
      -- },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
      },
    },
    -- root = vim.fn.getcwd(),
  },
}
