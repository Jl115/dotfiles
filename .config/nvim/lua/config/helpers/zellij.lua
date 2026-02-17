local function unlock_zellij()
  vim.fn.system("zellij action switch-mode normal")
end

local function lock_zellij()
  vim.fn.system("zellij action switch-mode locked")
end

if os.getenv("ZELLIJ") then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = lock_zellij,
  })

  vim.api.nvim_create_autocmd("VimLeave", {
    callback = unlock_zellij,
  })

  vim.api.nvim_create_autocmd("VimSuspend", {
    callback = unlock_zellij,
  })

  vim.api.nvim_create_autocmd("VimResume", {
    callback = lock_zellij,
  })
end
