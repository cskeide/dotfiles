-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- in your keymaps config
local diagnostics_enabled = true

vim.keymap.set("n", "<leader>xv", function()
  diagnostics_enabled = not diagnostics_enabled
  vim.diagnostic.config({
    virtual_text = diagnostics_enabled,
    signs = true,
    underline = diagnostics_enabled,
  })
  vim.notify("Inline Diagnostics " .. (diagnostics_enabled and "enabled" or "disabled"))
end, { desc = "Toggle Inline Diagnostics" })
