local M = {}

function M.auto_quit()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  -- Both neo-tree and aerial will auto-quit if there is only a single window left
  if #wins <= 1 then
    return
  end
  local sidebar_fts = { aerial = true, ["neo-tree"] = true }
  for _, winid in ipairs(wins) do
    if vim.api.nvim_win_is_valid(winid) then
      local bufnr = vim.api.nvim_win_get_buf(winid)
      local filetype = vim.bo[bufnr].filetype
      -- If any visible windows are not sidebars, early return
      if not sidebar_fts[filetype] then
        return
        -- If the visible window is a sidebar
      else
        -- only count filetypes once, so remove a found sidebar from the detection
        sidebar_fts[filetype] = nil
      end
    end
  end
  if #vim.api.nvim_list_tabpages() > 1 then
    vim.cmd.tabclose()
  else
    vim.cmd.qall()
  end
end

return M
